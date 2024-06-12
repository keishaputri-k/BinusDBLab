--CREATE TABLE
CREATE TABLE City (
	CityID CHAR(5) PRIMARY KEY CHECK (CityID LIKE 'CI[0-9][0-9][0-9]'),
	CityName VARCHAR (50) NOT NULL
)

CREATE TABLE Customer (
	CustomerID CHAR(5) PRIMARY KEY CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CityID CHAR (5) FOREIGN KEY REFERENCES City (CityID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CustomerName VARCHAR (50) NOT NULL,
	CustomerDOB DATE NOT NULL,
	CustomerGender VARCHAR (50) NOT NULL,
	CustomerAddress VARCHAR (50) NOT NULL
)


CREATE TABLE MemberShip (
	MemberShipID CHAR(5) PRIMARY KEY CHECK (MemberShipID LIKE 'ME[0-9][0-9][0-9]'),
	CustomerID CHAR (5) FOREIGN KEY REFERENCES Customer (CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL
)



CREATE TABLE DrinkType (
	DrinkTypeID CHAR(5) PRIMARY KEY CHECK (DrinkTypeID LIKE 'DT[0-9][0-9][0-9]'),
	DrinkTypeName VARCHAR (50) NOT NULL
)

CREATE TABLE Drink (
	DrinkID CHAR(5) PRIMARY KEY CHECK (DrinkID LIKE 'DR[0-9][0-9][0-9]'),
	DrinkTypeID CHAR(5) FOREIGN KEY REFERENCES DrinkType (DrinkTypeID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkName VARCHAR (50) NOT NULL,
	DrinkQuantity INT NOT NULL,
	DrinkPrice INT NOT NULL
)

CREATE TABLE Position (
	PositionID CHAR(5) PRIMARY KEY CHECK (PositionID LIKE 'SP[0-9][0-9][0-9]'),
	PositionName VARCHAR (50) NOT NULL
)

CREATE TABLE Staff (
	StaffID CHAR(5) PRIMARY KEY CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]'),
	PositionID CHAR(5) FOREIGN KEY REFERENCES Position(PositionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	StaffName VARCHAR (50) NOT NULL,
	StaffGender VARCHAR (50) NOT NULL,
	StaffDOB DATE NOT NULL
)

CREATE TABLE TransactionHeader (
	TransactionID CHAR(5) PRIMARY KEY CHECK (TransactionID LIKE 'TR[0-9][0-9][0-9]'),
	CustomerID CHAR (5) FOREIGN KEY REFERENCES Customer (CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	StaffID CHAR (5) FOREIGN KEY REFERENCES Staff (StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkID CHAR (5) FOREIGN KEY REFERENCES Drink (DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TransactionDate DATE NOT NULL
)

CREATE TABLE TransactionDetail (
	TransactionID CHAR (5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkID CHAR (5) FOREIGN KEY REFERENCES Drink (DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TransactionDrinkSold INT NOT NULL,
	TransactionDrinkQuantity INT NOT NULL,
	PRIMARY KEY (TransactionID)
)

--ALTER TABLE 
ALTER TABLE Customer
ADD CONSTRAINT Cn_Name
CHECK (LEN(CustomerName) >=3)


ALTER TABLE Customer
ADD CONSTRAINT Cn_Gender
CHECK (CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female')

ALTER TABLE Customer
ADD Constraint Cn_Address
CHECK (CustomerAddress LIKE '%Street' OR
	CustomerAddress LIKE '%Avenue' OR
	CustomerAddress LIKE '%Lane' OR
	CustomerAddress LIKE '%Terrace' OR
	CustomerAddress LIKE '%Hill' OR
	CustomerAddress LIKE '%Road' OR
	CustomerAddress LIKE '%Path' OR
	CustomerAddress LIKE '%Center'
)

ALTER TABLE City
ADD Constraint Ct_Name
CHECK (LEN(CityName) >=5)


ALTER TABLE Staff
ADD Constraint St_Name
CHECK (LEN(StaffName) >=3)

ALTER TABLE Staff
ADD Constraint St_Gender
CHECK (StaffGender LIKE 'Male' OR StaffGender LIKE'Female')

ALTER TABLE Position
ADD Constraint Po_Name
CHECK (LEN(PositionName)>=5)

ALTER TABLE Drink
ADD Constraint Dn_Quantity
CHECK (DrinkQuantity > 0)

ALTER TABLE Drink
ADD Constraint Dn_Price
CHECK (DrinkPrice between 15000 AND 60000)

ALTER Table TransactionHeader
ADD Constraint Tn_Quantity
CHECK (TransactionDrinkQuantity>0)


ALTER TABLE Drink
ADD Constraint Dn_Name
CHECK (CHARINDEX(' ', DrinkName) > 0)

ALTER TABLE DrinkType
ADD CONSTRAINT DN_TypeName CHECK (LEN(LTRIM(RTRIM(DrinkTypeName))) > 0)


--INSERT VALUES 
INSERT INTO DrinkType VALUES 
	('DT001', 'Tea'),
   	('DT002', 'Coffee'),
    ('DT003', 'Milkshake'),
    ('DT004', 'Soda'),
    ('DT005', 'Smoothie'),
    ('DT006', 'Juice'),
    ('DT007', 'Alcohol');

INSERT INTO City VALUES 
	('CI001', 'Jakarta'),
   	('CI002', 'Surabaya'),
   	('CI003', 'Bandung'),
   	('CI004', 'Medan'),
   	('CI005', 'Semarang'),
   	('CI006', 'Palembang'),
   	('CI007', 'Makassar'),
   	('CI008', 'Bogor'),
   	('CI009', 'Depok'),
    ('CI010', 'Tangerang');

INSERT INTO Customer VALUES 
	('CU001', 'CI001', 'John Doe', '1990-01-01', 'Male', 'Jalan Sudirman Terrace'),
   	('CU002', 'CI002', 'Jane Doe', '1995-05-15', 'Female', 'Jalan Pahlawan Street'),
   	('CU003', 'CI003', 'Ali Ahmad', '1980-10-20', 'Male', 'Jalan Merdeka Avenue'),
   	('CU004', 'CI004', 'Siti Nurhaliza', '1998-07-07', 'Female', 'Jalan Gatot Subroto No.21 Lane'),
   	('CU005', 'CI005', 'Michael Chen', '1975-03-03', 'Male', 'Jalan Gajah Mada Hill'),
   	('CU006', 'CI001', 'Bunga Citra Lestari', '1987-12-25', 'Female', 'Jalan Thamrin Road'),
    ('CU007', 'CI002', 'Budi Santoso', '1992-09-09', 'Male', 'Jalan Pemuda Terrace'),
   	('CU008', 'CI003', 'Megawati Soekarnoputri', '1949-01-23', 'Female', 'Jalan Bangka Avenue'),
    ('CU009', 'CI005', 'Susilo Bambang Yudhoyono', '1949-09-09', 'Male', 'Jalan Raya Anyer Hill'),
    ('CU010', 'CI004', 'Agus Salim', '1884-08-08', 'Male', 'Jalan KH Hasyim Asyari Avenue');

INSERT INTO Drink VALUES 
	('DR001', 'DT001', 'Lipton Tea', '10', '20000'),
    ('DR002', 'DT002', 'Espresso', '10', '20000'),
    ('DR003', 'DT003', 'Chocolate Milkshake', '10', '20000'),
    ('DR004', 'DT004', 'Coca-Cola', '10', '20000'),
    ('DR005', 'DT005', 'Mango Smoothie', '10', '20000'),
    ('DR006', 'DT006', 'Orange Juice', '10', '20000'),
    ('DR007', 'DT007', 'Red Wine', '10', '20000'),
	('DR008', 'DT005', 'Strawberry Smoothie', '10', '22000'),
    ('DR009', 'DT002', 'Latte', '10', '23000'),
    ('DR010', 'DT001', 'Green Tea', '10', '19000');

INSERT INTO Position VALUES 
	    ('SP001', 'Waiter');

INSERT INTO Staff VALUES 
	 ('ST001', 'SP001', 'Sarah Lee', 'Female', '1995-02-14'),
	 ('ST002', 'SP001', 'Ahmad Brown', 'Male', '1992-08-21'),
	 ('ST003', 'SP001', 'Michael Garcia', 'Male', '1988-07-07'),
	 ('ST004', 'SP001', 'Siti Nurhaliza', 'Female', '1998-07-07'),
	 ('ST005', 'SP001', 'Budi Santoso', 'Male', '1992-09-09'),
	 ('ST006', 'SP001', 'Megawati Soekarnoputri', 'Female', '1949-01-23'),        
	 ('ST007', 'SP001', 'Susilo Bambang Yudhoyono', 'Male', '1949-09-09'),
	 ('ST008', 'SP001', 'Agus Salim', 'Male', '1884-08-08'),
	 ('ST009', 'SP001', 'Sukarno', 'Male', '1901-06-06'),
	 ('ST010', 'SP001', 'Hatta', 'Male', '1902-08-12');

INSERT INTO MemberShip VALUES 
	('ME001', 'CU001', '2023-01-01', '2024-01-01'),
    ('ME002', 'CU002', '2022-07-15', '2023-07-15'),
    ('ME003', 'CU003', '2021-05-20', '2022-05-20'),
    ('ME004', 'CU005', '2023-11-11', '2024-11-11'),  
    ('ME005', 'CU004', '2022-04-04', '2023-04-04'),
    ('ME006', 'CU001', '2020-09-09', '2021-09-09'),
    ('ME007', 'CU009', '2023-03-03', '2024-03-03'),
    ('ME008', 'CU007', '2022-02-02', '2023-02-02'),
    ('ME009', 'CU008', '2021-01-01', '2022-01-01'),
    ('ME010', 'CU006', '2020-12-12', '2021-12-12');  

INSERT INTO TransactionHeader VALUES 
	('TR001', 'CU001', 'ST001', '2024-01-11'),  
    ('TR002', 'CU002', 'ST002', '2024-02-15'), 
    ('TR003', 'CU004', 'ST004', '2024-03-04'), 
	('TR004', 'CU006', 'ST006', '2024-06-07'),
	('TR005', 'CU003', 'ST003', '2024-05-08'),
	('TR006', 'CU002', 'ST002', '2024-12-30'),
	('TR007', 'CU008', 'ST008', '2024-11-02'),
	('TR008', 'CU006', 'ST006', '2024-10-31'),
	('TR009', 'CU006', 'ST006', '2023-10-29'),
	('TR010', 'CU007', 'ST007', '2023-07-19'),
	('TR011', 'CU005', 'ST005', '2023-08-07'),
	('TR012', 'CU009', 'ST009', '2023-09-03'),
	('TR013', 'CU005', 'ST005', '2023-09-04'),
	('TR014', 'CU005', 'ST005', '2023-08-11'),
	('TR015', 'CU004', 'ST004', '2022-11-15'),
	('TR016', 'CU003', 'ST003', '2022-12-22'),
	('TR017', 'CU002', 'ST002', '2022-10-31'),
	('TR018', 'CU007', 'ST007', '2022-10-26'),
	('TR019', 'CU009', 'ST009', '2022-01-02'),
	('TR020', 'CU009', 'ST009', '2022-01-23'),
	('TR021', 'CU010', 'ST010', '2022-03-11'),
	('TR022', 'CU001', 'ST001', '2023-02-10'),
	('TR023', 'CU004', 'ST004', '2023-04-01'),
	('TR024', 'CU010', 'ST010', '2023-07-30'),
	('TR025', 'CU008', 'ST008', '2021-01-31');

INSERT INTO TransactionDetail VALUES 
	('TR001', 'DR001', '8','2'),
    ('TR002', 'DR002', '7', '1'),
    ('TR003', 'DR004', '5','1' ),
	('TR004', 'DR006', '4', '1'),
	('TR005', 'DR003', '2', '3'),
	('TR006', 'DR002', '1', '5'),
	('TR007', 'DR008', '3', '2'),
	('TR008', 'DR006', '24', '1'),
	('TR009', 'DR006', '2', '2'),
	('TR010', 'DR007', '5', '2'),
	('TR011', 'DR005', '10', '3'),
	('TR012', 'DR009', '22', '1'),
	('TR013', 'DR005', '4', '1'),
	('TR014', 'DR005', '4', '4'),
	('TR015', 'DR004', '5', '3'),
	('TR016', 'DR003', '6', '5'),
	('TR017', 'DR002', '8', '4'),
	('TR018', 'DR007', '12', '2'),
	('TR019', 'DR009', '10', '1'),
	('TR020', 'DR009', '3', '2'),
	('TR021', 'DR010', '4', '1'),
	('TR022', 'DR001', '6', '2'),
	('TR023', 'DR004', '9', '2'),
	('TR024', 'DR010', '5', '4'),
	('TR025', 'DR008', '3', '3');

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

--Transaction Simulation
INSERT INTO TransactionDetail1 VALUES 
    ('TR026', 'DR009', '8','2'),
    ('TR027', 'DR002', '3','2'),
    ('TR028', 'DR007', '5','1')

INSERT INTO TransactionHeader1 VALUES 
    ('TR029', 'CU002', 'ST010', '2024-06-08'),
    ('TR027', 'CU008', 'ST002', '2024-06-03'), 
    ('TR028', 'CU009', 'ST004', '2024-05-24')

UPDATE Drink d
INNER JOIN TransactionDetail td ON d.DrinkID = td.DrinkID
SET d.DrinkQuantity = d.DrinkQuantity - td.TransactionDrinkQuantity
WHERE td.TransactionID IN (
  SELECT TransactionID
  FROM TransactionHeader th
);
