-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (2, '201312', NULL), (12, 'SME', 'SME'), (11, '201312', '2013'), (4, 'default1', '201301'), (5, '2013', 'default2'), (13, 'default2', 'default2'), (0, NULL, '201301'), (1, '2013', NULL), (3, '201312', 'default2'), (6, 'default2', NULL), (7, NULL, 'default1'), (8, '201301', '201301'), (9, 'SME', 'default2'), (10, 'SME', NULL), (14, 'SME', 'SME'), (15, '201301', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (14, '2013', 0.0), (6, '201312', 11.0), (5, '201301', 0.0), (3, '201301', NULL), (13, 'default2', 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.Consumption) / 12 FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT AVG(Consumption) / 12 FROM yearmonth WHERE Date BETWEEN '201301' AND '201312' AND CustomerID IN (SELECT CustomerID FROM customers WHERE Segment = 'SME');

/*
Prediction Result:
(None,)
*/