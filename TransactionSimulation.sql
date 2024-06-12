--Transaction Simulation
INSERT INTO TransactionDetail1 VALUES 
    ('TR026', 'DR009', '8','2'),
    ('TR027', 'DR002', '3','2'),
    ('TR028', 'DR007', '5','1')

INSERT INTO TransactionHeader1 VALUES 
    ('TR029', 'CU002', 'ST010', '2024-06-08'),
    ('TR027', 'CU008', 'ST002', '2024-06-03'), 
    ('TR028', 'CU009', 'ST004', '2024-05-24')

UPDATE Drink 
SET Drink.DrinkQuantity = Drink.DrinkQuantity - td.TransactionDrinkQuantity
FROM Drink
INNER JOIN TransactionDetail1 AS td ON Drink.DrinkID = td.DrinkID
INNER JOIN TransactionHeader1 AS th ON td.TransactionID = th.TransactionID
WHERE th.TransactionID IN (
  'TR026', 'TR027', 'TR028'
);