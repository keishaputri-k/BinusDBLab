CREATE TABLE City (
	CityID CHAR(5) PRIMARY KEY CHECK (CityID LIKE 'CI[0-9][0-9][0-9]'),
	CityName VARCHAR (50) NOT NULL,
)

CREATE TABLE Customer (
	CustomerID CHAR(5) PRIMARY KEY CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CityID CHAR (5) FOREIGN KEY REFERENCES City (CityID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CustomerName VARCHAR (50) NOT NULL,
	CustomerDOB DATE NOT NULL,
	CustomerGender VARCHAR (50) NOT NULL,
	CustomerAddress VARCHAR (50) NOT NULL,
)


CREATE TABLE MemberShip (
	MemberShipID CHAR(5) PRIMARY KEY CHECK (MemberShipID LIKE 'ME[0-9][0-9][0-9]'),
	CustomerID CHAR (5) FOREIGN KEY REFERENCES Customer (CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
)



CREATE TABLE DrinkType (
	DrinkTypeID CHAR(5) PRIMARY KEY CHECK (DrinkTypeID LIKE 'DT[0-9][0-9][0-9]'),
	DrinkTypeName VARCHAR (50) NOT NULL,
)

CREATE TABLE Drink (
	DrinkID CHAR(5) PRIMARY KEY CHECK (DrinkID LIKE 'DR[0-9][0-9][0-9]'),
	DrinkTypeID CHAR(5) FOREIGN KEY REFERENCES DrinkType (DrinkTypeID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkName VARCHAR (50) NOT NULL,
	DrinkQuantity INT NOT NULL,
	DrinkPrice INT NOT NULL,
)

CREATE TABLE Position (
	PositionID CHAR(5) PRIMARY KEY CHECK (PositionID LIKE 'SP[0-9][0-9][0-9]'),
	PositionName VARCHAR (50) NOT NULL,
)

CREATE TABLE Staff (
	StaffID CHAR(5) PRIMARY KEY CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]'),
	PositionID CHAR(5) FOREIGN KEY REFERENCES Position(PositionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	StaffName VARCHAR (50) NOT NULL,
	StaffGender VARCHAR (50) NOT NULL,
	StaffDOB DATE NOT NULL,
)

CREATE TABLE TransactionHeader (
	TransactionID CHAR(5) PRIMARY KEY CHECK (TransactionID LIKE 'TR[0-9][0-9][0-9]'),
	CustomerID CHAR (5) FOREIGN KEY REFERENCES Customer (CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	StaffID CHAR (5) FOREIGN KEY REFERENCES Staff (StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkID CHAR (5) FOREIGN KEY REFERENCES Drink (DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TransactionDate DATE NOT NULL,
)

CREATE TABLE TransactionDetail (
	TransactionID CHAR (5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkID CHAR (5) FOREIGN KEY REFERENCES Drink (DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TransactionDrinkSold INT NOT NULL,
	TransactionDrinkQuantity INT NOT NULL,
	PRIMARY KEY (TransactionID)
)

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
	('CU001', 'CI001', 'John Doe', '1990-01-01', 'Male', 'Jalan Sudirman No.1'),
    ('CU002', 'CI002', 'Jane Doe', '1995-05-15', 'Female', 'Jalan Pahlawan No.100'),
    ('CU003', 'CI003', 'Ali Ahmad', '1980-10-20', 'Male', 'Jalan Merdeka No.50'),
    ('CU004', 'CI004', 'Siti Nurhaliza', '1998-07-07', 'Female', 'Jalan Gatot Subroto No.21'),
    ('CU005', 'CI005', 'Michael Chen', '1975-03-03', 'Male', 'Jalan Gajah Mada No.30'),
    ('CU006', 'CI001', 'Bunga Citra Lestari', '1987-12-25', 'Female', 'Jalan Thamrin No.17'),
    ('CU007', 'CI002', 'Budi Santoso', '1992-09-09', 'Male', 'Jalan Pemuda No.65'),
    ('CU008', 'CI003', 'Megawati Soekarnoputri', '1949-01-23', 'Female', 'Jalan Bangka No.4'),
    ('CU009', 'CI005', 'Susilo Bambang Yudhoyono', '1949-09-09', 'Male', 'Jalan Raya Anyer No.99'),
    ('CU010', 'CI004', 'Agus Salim', '1884-08-08', 'Male', 'Jalan KH Hasyim Asyari No.1');

INSERT INTO Drink VALUES 
	('DR001', 'DT001', 'Lipton Tea', 10, 20000),
    ('DR002', 'DT002', 'Espresso', 10, 20000),
    ('DR003', 'DT003', 'Chocolate Milkshake', 10, 20000),
    ('DR004', 'DT004', 'Coca-Cola', 10, 20000),
    ('DR005', 'DT005', 'Mango Smoothie', 10, 20000),
    ('DR006', 'DT006', 'Orange Juice', 10, 20000),
    ('DR007', 'DT007', 'Red Wine', 10, 20000),
	('DR008', 'DT005', 'Strawberry Smoothie', 10, 22000),
    ('DR009', 'DT002', 'Latte', 10, 23000),
    ('DR010', 'DT001', 'Green Tea', 10, 19000);

INSERT INTO Position VALUES 
	('SP001', 'Waiter');

INSERT INTO Staff VALUES 
	('ST001', 'SP001', 'Sarah Lee', 'Female', '1995-02-14'),
    ('ST002', 'SP001', 'Ahmad Brown', 'Male', '1992-08-21'),
    ('ST003', 'SP001', 'Michael Garcia', 'Male', '1988-07-07'),
    ('ST004', 'SP002', 'Siti Nurhaliza', 'Female', '1998-07-07'),
    ('ST005', 'SP002', 'Budi Santoso', 'Male', '1992-09-09'),
    ('ST006', 'SP001', 'Megawati Soekarnoputri', 'Female', '1949-01-23'),
    ('ST007', 'SP002', 'Susilo Bambang Yudhoyono', 'Male', '1949-09-09'),
    ('ST008', 'SP001', 'Agus Salim', 'Male', '1884-08-08'),
    ('ST009', 'SP002', 'Sukarno', 'Male', '1901-06-06'),
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
	('TR001', 'CU001', 'ST001', '2024-06-05'),  
    ('TR002', 'CU002', 'ST002', '2024-06-05'), 
    ('TR003', 'CU004', 'ST004', '2024-06-05'), 
	('TR004', 'CU006', 'ST006', '2024-06-05'),
	('TR005', 'CU003', 'ST003', '2024-06-05'),
	('TR006', 'CU002', 'ST002', '2024-06-05'),
	('TR007', 'CU008', 'ST008', '2024-06-05'),
	('TR008', 'CU006', 'ST006', '2024-06-05'),
	('TR009', 'CU006', 'ST006', '2024-06-05'),
	('TR010', 'CU007', 'ST007', '2024-06-05'),
	('TR011', 'CU005', 'ST005', '2024-06-05'),
	('TR012', 'CU009', 'ST009', '2024-06-05'),
	('TR013', 'CU005', 'ST005', '2024-06-05'),
	('TR014', 'CU005', 'ST005', '2024-06-05'),
	('TR015', 'CU004', 'ST004', '2024-06-05'),
	('TR016', 'CU003', 'ST003', '2024-06-05'),
	('TR017', 'CU002', 'ST002', '2024-06-05'),
	('TR018', 'CU007', 'ST007', '2024-06-05'),
	('TR019', 'CU009', 'ST009', '2024-06-05'),
	('TR020', 'CU009', 'ST009', '2024-06-05'),
	('TR021', 'CU010', 'ST010', '2024-06-05'),
	('TR022', 'CU001', 'ST001', '2024-06-05'),
	('TR023', 'CU004', 'ST004', '2024-06-05'),
	('TR024', 'CU010', 'ST010', '2024-06-05'),
	('TR025', 'CU008', 'ST008', '2024-06-05');

INSERT INTO TransactionDetail VALUES 
	('TR001', 'DR001', 8, ),
    ('TR002', 'DR002', 7, ),
    ('TR003', 'DR004', 5, ),
	('TR004', 'DR006', 4, ),
	('TR005', 'DR003', 2, ),
	('TR006', 'DR002', 1, ),
	('TR007', 'DR008', 3, ),
	('TR008', 'DR006', 24, ),
	('TR009', 'DR006', 2, ),
	('TR010', 'DR007', 5, ),
	('TR011', 'DR005', 10, ),
	('TR012', 'DR009', 22, ),
	('TR013', 'DR005', 4, ),
	('TR014', 'DR005', 4, ),
	('TR015', 'DR004', 5, ),
	('TR016', 'DR003', 6, ),
	('TR017', 'DR002', 8, ),
	('TR018', 'DR007', 12, ),
	('TR019', 'DR009', 10, ),
	('TR020', 'DR009', 3, ),
	('TR021', 'DR010', 4, ),
	('TR022', 'DR001', 6, ),
	('TR023', 'DR004', 9, ),
	('TR024', 'DR010', 5, ),
	('TR025', 'DR008', 3, );


