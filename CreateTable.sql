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
