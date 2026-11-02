-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (2, 'default1', 'default1'), (0, 'KAM', NULL), (1, NULL, 'default2'), (3, NULL, 'default2'), (4, 'KAM', 'KAM'), (5, 'default1', 'KAM'), (6, NULL, NULL), (7, 'default1', NULL), (8, 'KAM', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (2, 'default2', NULL), (5, 'KAM', NULL), (8, 'default2', 0.0), (4, 'default1', 2.0), (0, 'default1', 2.0), (2, 'default1', 0.0), (0, 'default2', 0.0), (2, 'KAM', 2.0), (0, 'KAM', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' GROUP BY T2.CustomerID ORDER BY SUM(T2.Consumption) DESC, T2.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(0, 3.0)
*/

-- Prediction Query
SELECT T1.CustomerID, T2.Consumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' ORDER BY T2.Consumption DESC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(0, 2.0)
*/