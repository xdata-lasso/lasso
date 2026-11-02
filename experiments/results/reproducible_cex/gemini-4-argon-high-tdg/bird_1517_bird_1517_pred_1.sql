-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (100, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (200, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (300, 'SME', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 2, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (30, 3, 'SVK', 'Discount');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (2, 'Natural 95');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '08:00:00', 100, 1001, 10, 1, 10, 250.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-26', '09:30:00', 200, 1002, 20, 2, 5, 120.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-24', '22:15:00', 300, 1003, 30, 1, 8, 200.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (100, '201201', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (200, '201202', 300.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (300, '201208', 800.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
('SME',)
*/

-- Prediction Query
SELECT Segment FROM customers WHERE CustomerID = (SELECT MIN(CustomerID) FROM customers);

/*
Prediction Result:
('KAM',)
*/