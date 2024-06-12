--SOAL
--1
SELECT 
    ST.StaffName,
    SUM(TD.TransactionDrinkQuantity) AS DrinkSold
FROM 
    Staff ST
JOIN 
    TransactionHeader1 TH ON TH.StaffID = ST.StaffID
JOIN 
    TransactionDetail1 TD ON TD.TransactionID = TH.TransactionID
WHERE 
    TH.TransactionDate > '2021-12-31' AND  DATEDIFF(YEAR, ST.StaffDOB, '2023-12-12') > 26
GROUP BY 
    ST.StaffName;

--2
SELECT
	CONCAT('Mrs./Ms ', UPPER(StaffName)) AS StaffName,
	COUNT(CU.CustomerID) AS TotalCustomers 
FROM Staff S JOIN 
	TransactionHeader1 TH ON TH.StaffID = S.StaffID JOIN 
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
             TransactionHeader1 TH ON TH.CustomerID = CU.CustomerID
         JOIN 
             TransactionDetail1 TD ON TD.TransactionID = TH.TransactionID
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
        TransactionHeader1 TH ON TH.CustomerID = CU.CustomerID
    JOIN 
        TransactionDetail1 TD ON TD.TransactionID = TH.TransactionID
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
    DATEDIFF('2023-12-12', c.CustomerDOB) AS CustomerAge,
     CONVERT(VARCHAR, c.CustomerDOB, 106) AS CustomerDOB,
    ct.CityName
FROM 
    Customer c
    JOIN City ct ON c.CityID = ct.CityID
    JOIN MemberShip m ON c.CustomerID = m.CustomerID
WHERE 
    DATEDIFF('2023-12-12', c.CustomerDOB) > (
        SELECT 
            AVG(age_diff)
        FROM 
            (SELECT DATEDIFF('2023-12-12', CustomerDOB) AS age_diff
             FROM Customer) AS avg_age
    )
    AND YEAR(m.EndDate) = 2023;

--6
SELECT 
    CONCAT(p.PositionName, ' ', s.StaffName) AS Staff,
    FORMAT(SUM(td.DrinkQuantity * 50000), 'id_ID') AS StaffBonus
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
ORDER BY 
    th.TransactionID;

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
           SUBSTRING_INDEX(SUBSTRING_INDEX(d.DrinkName, ' ', 2), ' ', -1), LEFT(dt.DrinkTypeName, 1)) AS DrinkCode,
   		 D.DrinkName,
   		FORMAT(d.DrinkPrice * 0.9, 0, 'id_ID') AS DrinkDiscountedPrice,
    	FORMAT(SUM(d.DrinkPrice * 0.9 * td.TransactionDrinkQuantity), 0, 'id_ID') AS TotalProfit,
    	DT.DrinkTypeName
    FROM 
        Drink d
        JOIN DrinkType dt ON d.DrinkTypeID = dt.DrinkTypeID
        JOIN TransactionDetail td ON d.DrinkID = td.DrinkID
        JOIN TransactionHeader th ON td.TransactionID = th.TransactionID
    WHERE 
        MONTH(th.TransactionDate) > 6
        AND d.DrinkName LIKE '%a%'
    GROUP BY 
        d.DrinkID
) AS subquery
ORDER BY 
    subquery.DrinkID;

--8
SELECT 
    subquery.DrinkName,
    subquery.CustomerName,
    subquery.DaysAgo,
    subquery.Quantity
FROM (
    SELECT 
        CONCAT(SUBSTRING_INDEX(d.DrinkName, ' ', 1), ' ', SUBSTRING_INDEX(d.DrinkName, ' ', -1)) AS DrinkName,
        c.CustomerName,
        DATEDIFF('2023-12-12', th.TransactionDate) AS DaysAgo,
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
TransactionDetail1 TD ON TD.DrinkID = D.DrinkID JOIN 
TransactionHeader1 TH ON TH.TransactionID = TD.TransactionID 
WHERE DrinkTypeName IN ('Boba','Juice', 'Milkshake', 'Smoothie', 'Tea') AND  MONTH(TH.TransactionDate) > 6
GROUP BY DrinkTypeName

--10
CREATE VIEW TotalCustomersBasedOnCity AS 
SELECT CityName,COUNT(CU.CustomerID) AS TotalCustomer,
		CONCAT (MIN(TransactionDrinkSold) , ' Drinks') AS MinAmountOfDrinksBought
FROM City C JOIN 
Customer CU ON CU.CityID = C.CityID JOIN 
TransactionHeader1 TH ON TH.CustomerID = CU.CustomerID JOIN 
TransactionDetail1 TD ON TD.TransactionID = TH.TransactionID 
WHERE CityName LIKE '%Road'
GROUP BY CityName