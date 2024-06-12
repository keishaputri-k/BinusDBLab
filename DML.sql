--SOAL
--1
SELECT 
    ST.StaffName,
    SUM(TD.TransactionDrinkQuantity) AS DrinkSold
FROM 
    Staff ST
JOIN 
    TransactionHeader TH ON TH.StaffID = ST.StaffID
JOIN 
    TransactionDetail TD ON TD.TransactionID = TH.TransactionID
WHERE 
    TH.TransactionDate > '2021-12-31' AND  DATEDIFF(YEAR, ST.StaffDOB, '2023-12-12') > 26
GROUP BY 
    ST.StaffName;

--2
SELECT
	CONCAT('Mrs./Ms ', UPPER(StaffName)) AS StaffName,
	COUNT(CU.CustomerID) AS TotalCustomers 
FROM Staff S JOIN 
	TransactionHeader TH ON TH.StaffID = S.StaffID JOIN 
	Customer CU ON CU.CustomerID = TH.CustomerID JOIN 
	City CI ON CI.CityID = CU.CityID
WHERE StaffGender LIKE 'Female' and CityName LIKE '%Village'
GROUP BY CONCAT('Mrs. ', UPPER(StaffName))
ORDER BY COUNT(CU.CustomerID) DESC

--3
SELECT 
    CustomerID,
    CustomerName,
    TotalTransaction,
    (SELECT MAX(TotalTransaction) 
     FROM (
         SELECT 
             SUM(D.DrinkPrice * TD.TransactionDrinkQuantity) AS TotalTransaction
         FROM 
             Customer CU
         JOIN 
             TransactionHeader TH ON TH.CustomerID = CU.CustomerID
         JOIN 
             TransactionDetail TD ON TD.TransactionID = TH.TransactionID
         JOIN 
             Drink D ON TD.DrinkID = D.DrinkID
         WHERE 
             CU.CustomerGender = 'Male' AND
             TH.TransactionDate < '2022-01-01'
         GROUP BY 
             CU.CustomerID
     ) AS Subquery) AS MaxTransaction
FROM (
    SELECT 
        REPLACE(CU.CustomerID, 'CU', 'Customer ') AS CustomerID,
        CONCAT('Mr. ', CU.CustomerName) AS CustomerName,
        SUM(D.DrinkPrice * TD.TransactionDrinkQuantity) AS TotalTransaction
    FROM 
        Customer CU
    JOIN 
        TransactionHeader TH ON TH.CustomerID = CU.CustomerID
    JOIN 
        TransactionDetail TD ON TD.TransactionID = TH.TransactionID
    JOIN 
        Drink D ON TD.DrinkID = D.DrinkID
    WHERE 
        CU.CustomerGender = 'Male' AND
        TH.TransactionDate < '2022-01-01'
    GROUP BY 
        REPLACE(CU.CustomerID, 'CU', 'Customer '), CONCAT('Mr. ', CU.CustomerName)
) AS Transactions;

-- 4
SELECT UPPER(DrinkTypeName) AS DrinkTypeName,
SUM(TransactionDrinkQuantity) AS TotalDrinksBought,
CONCAT('Rp ', (AVG(DrinkPrice))) AS AveragePrice
FROM DrinkType DT JOIN 
Drink D ON D.DrinkTypeID = DT.DrinkTypeID JOIN 
TransactionDetail TD ON TD.DrinkID = D.DrinkID JOIN 
TransactionHeader TH ON TH.TransactionID = TD.TransactionID
WHERE DrinkTypeName IN ('Alcohol', 'Cocktail')
    AND DATENAME(weekday, TransactionDate) IN ('Monday', 'Wednesday', 'Friday')
GROUP BY UPPER(DrinkTypeName)


-- 5
SELECT 
  c.CustomerName,
  DATEDIFF(YEAR, c.CustomerDOB, '2023-12-12') AS CustomerAge,
  FORMAT(c.CustomerDOB, 'dd MMM yyyy') AS CustomerDOB,
  ct.CityName
FROM 
  Customer c
  JOIN City ct ON c.CityID = ct.CityID
  JOIN MemberShip m ON c.CustomerID = m.CustomerID
WHERE 
  DATEDIFF(YEAR, c.CustomerDOB, '2023-12-12') > (
    SELECT 
      AVG(age_diff)
    FROM 
      (SELECT DATEDIFF(YEAR, CustomerDOB, '2023-12-12') AS age_diff
       FROM Customer) AS avg_age
  )
  AND YEAR(m.EndDate) = 2023;

--6
  SELECT 
    CONCAT(p.PositionName, ' ', s.StaffName) AS Staff,
    FORMAT(SUM(td.TransactionDrinkQuantity * 50000), 'N', 'id-ID') AS StaffBonus
FROM 
    TransactionHeader th
    JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
    JOIN Staff s ON th.StaffID = s.StaffID
    JOIN Position p ON s.PositionID = p.PositionID
WHERE 
    td.TransactionDrinkQuantity > (
        SELECT AVG(avg_td.TransactionDrinkQuantity)
        FROM (
            SELECT td.TransactionDrinkQuantity
            FROM TransactionDetail td
            JOIN TransactionHeader th ON td.TransactionID = th.TransactionID
            JOIN Staff s ON th.StaffID = s.StaffID
            JOIN Position p ON s.PositionID = p.PositionID
            WHERE p.PositionName <> 'Manager'
        ) AS avg_td
    ) 
    AND p.PositionName <> 'Manager'
GROUP BY 
    p.PositionName, s.StaffName
ORDER BY 
    SUM(td.TransactionDrinkQuantity * 50000) DESC;

-- 7
SELECT 
    subquery.DrinkCode,
    subquery.DrinkName,
    subquery.DrinkDiscountedPrice,
    subquery.TotalProfit,
    subquery.DrinkTypeName
FROM (
    SELECT 
        CONCAT(LEFT(d.DrinkName, 1), 
               SUBSTRING(d.DrinkName, CHARINDEX(' ', d.DrinkName) + 1, CHARINDEX(' ', d.DrinkName + ' ', CHARINDEX(' ', d.DrinkName) + 1) - CHARINDEX(' ', d.DrinkName) - 1), 
               LEFT(dt.DrinkTypeName, 1)) AS DrinkCode,
        d.DrinkName,
        FORMAT(d.DrinkPrice * 0.9, 'N0', 'id-ID') AS DrinkDiscountedPrice,
        FORMAT(SUM(d.DrinkPrice * 0.9 * td.TransactionDrinkQuantity), 'N0', 'id-ID') AS TotalProfit,
        dt.DrinkTypeName
    FROM 
        Drink d
        JOIN DrinkType dt ON d.DrinkTypeID = dt.DrinkTypeID
        JOIN TransactionDetail td ON d.DrinkID = td.DrinkID
        JOIN TransactionHeader th ON td.TransactionID = th.TransactionID
    WHERE 
        MONTH(th.TransactionDate) > 6
        AND d.DrinkName LIKE '%a%'
    GROUP BY 
        d.DrinkID, d.DrinkName, dt.DrinkTypeName, d.DrinkPrice
) AS subquery
ORDER BY 
    subquery.DrinkName;

--8
SELECT 
    subquery.DrinkName,
    subquery.CustomerName,
    subquery.DaysAgo,
    subquery.Quantity
FROM (
    SELECT 
        CONCAT(
            LEFT(d.DrinkName, CHARINDEX(' ', d.DrinkName + ' ') - 1), ' ', 
            REVERSE(LEFT(REVERSE(d.DrinkName), CHARINDEX(' ', REVERSE(d.DrinkName) + ' ') - 1))
        ) AS DrinkName,
        c.CustomerName,
        DATEDIFF(DAY, th.TransactionDate, '2023-12-12') AS DaysAgo,
        td.TransactionDrinkQuantity AS Quantity,
        td.TransactionID
    FROM 
        TransactionDetail td
        JOIN TransactionHeader th ON td.TransactionID = th.TransactionID
        JOIN Customer c ON th.CustomerID = c.CustomerID
        JOIN Drink d ON td.DrinkID = d.DrinkID
    WHERE 
        td.TransactionDrinkQuantity > (
            SELECT MIN(td2.TransactionDrinkQuantity)
            FROM TransactionDetail td2
        ) 
        AND td.TransactionDrinkQuantity < (
            SELECT MAX(td3.TransactionDrinkQuantity)
            FROM TransactionDetail td3
        )
) AS subquery
ORDER BY 
    subquery.TransactionID;

--9
CREATE VIEW TotalSalesDrinkType AS 
SELECT DrinkTypeName,
		CONCAT (SUM(TransactionDrinkSold) , ' Drinks') AS DrinksSold,
		AVG(DrinkPrice) AS AverageDrinkPrice
FROM DrinkType DT JOIN 
Drink D ON D.DrinkTypeID = DT.DrinkTypeID JOIN 
TransactionDetail TD ON TD.DrinkID = D.DrinkID JOIN 
TransactionHeader TH ON TH.TransactionID = TD.TransactionID 
WHERE DrinkTypeName IN ('Boba','Juice', 'Milkshake', 'Smoothie', 'Tea') AND  MONTH(TH.TransactionDate) > 6
GROUP BY DrinkTypeName

--10
CREATE VIEW TotalCustomersBasedOnCity AS 
SELECT CityName,COUNT(CU.CustomerID) AS TotalCustomer,
		CONCAT (MIN(TransactionDrinkSold) , ' Drinks') AS MinAmountOfDrinksBought
FROM City C JOIN 
Customer CU ON CU.CityID = C.CityID JOIN 
TransactionHeader TH ON TH.CustomerID = CU.CustomerID JOIN 
TransactionDetail TD ON TD.TransactionID = TH.TransactionID 
WHERE CityName LIKE '%Road'
GROUP BY CityName