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
    ('DR002', 'DT002', 'Espresso Coffee', '10', '20000'),
    ('DR003', 'DT003', 'Chocolate Milkshake', '10', '20000'),
    ('DR004', 'DT004', 'Coca-Cola Soda', '10', '20000'),
    ('DR005', 'DT005', 'Mango Smoothie', '10', '20000'),
    ('DR006', 'DT006', 'Orange Juice', '10', '20000'),
    ('DR007', 'DT007', 'Red Wine', '10', '20000'),
	('DR008', 'DT005', 'Strawberry Smoothie', '10', '22000'),
    ('DR009', 'DT002', 'Coffee Latte', '10', '23000'),
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