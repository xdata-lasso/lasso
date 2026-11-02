-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (101, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (102, 'LAM', 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value for money');
INSERT INTO products (ProductID, Description) VALUES (5, 'Diesel');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (101, '201208', 500.25);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (102, '201208', 120.75);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-10', '10:00:00', 101, 1001, 10, 5, 2, 60.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-11', '11:30:00', 101, 1001, 10, 5, 1, 29.5);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-12', '14:15:00', 102, 1002, 10, 5, 2, 58.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Price / T1.Amount > 29.00 AND T1.ProductID = 5 AND T2.Date = '201208';

/*
Gold Result:
(500.25,)
(500.25,)
(120.75,)
*/

-- Prediction Query
SELECT T1.Consumption FROM yearmonth AS T1 INNER JOIN (SELECT DISTINCT CustomerID FROM transactions_1k WHERE ProductID = 5 AND Price / Amount > 29) AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201208';

/*
Prediction Result:
(500.25,)
(120.75,)
*/