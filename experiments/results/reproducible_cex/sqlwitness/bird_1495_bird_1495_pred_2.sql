-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, NULL, 'default1'), (2, NULL, 'default2'), (0, 'default1', '201309'), (3, '201309', 'default1'), (4, 'default2', 'default2'), (5, 'default1', 'default2'), (6, NULL, 'default1'), (7, NULL, 'default1'), (8, 'default1', 'default2'), (9, '201309', 'default2'), (10, '201309', 'default2'), (11, 'default2', 'default1'), (12, 'default1', '201309'), (13, NULL, 'default2'), (14, NULL, 'default2'), (15, 'default1', 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (3, '201309', 2.0), (13, 'default2', 1.0), (15, '201309', 1.0), (10, '201309', 1.0), (5, '201309', 1.0), (8, 'default2', 2.0), (3, 'default2', 2.0), (6, '201309', NULL), (1, '201309', NULL), (6, 'default2', 2.0), (1, 'default2', 2.0), (14, 'default1', 1.0), (11, '201309', 0.0), (1, 'default1', 0.0), (7, '201309', 2.0), (13, '201309', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT yearmonth.customerid FROM yearmonth INNER JOIN (SELECT MAX(consumption) AS max_consumption FROM yearmonth WHERE date = '201309') AS max_values ON yearmonth.consumption = max_values.max_consumption AND yearmonth.date = '201309';

/*
Prediction Result:
(3,)
(7,)
*/