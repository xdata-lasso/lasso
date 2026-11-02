-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, WHERE clause boundary conditions ('201308', '201309', '201310'), and duplicate elimination (DISTINCT vs ALL).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'EUR');
INSERT INTO products (ProductID, Description) VALUES (10, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (20, 'Natural 95');
INSERT INTO products (ProductID, Description) VALUES (30, 'LPG');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201309', 150.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201308', 200.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201310', 300.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (100, '2012-08-24', '10:00:00', 1, 101, 1, 10, 50, 60.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (101, '2012-08-25', '11:00:00', 1, 101, 1, 10, 40, 48.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (102, '2012-08-26', '12:00:00', 2, 102, 2, 20, 30, 36.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (103, '2012-08-27', '13:00:00', 3, 103, 3, 30, 20, 24.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('Diesel',)
('Diesel',)
*/

-- Prediction Query
SELECT DISTINCT T3.Description FROM yearmonth AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T2.ProductID = T3.ProductID WHERE SUBSTRING(T1.Date, 1, 6) = '201309';

/*
Prediction Result:
('Diesel',)
*/