-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (3, 'default1', '201301'), (13, '201312', 'default2'), (11, 'SME', '2013'), (5, NULL, 'SME'), (4, 'SME', 'default2'), (2, 'SME', '201301'), (12, NULL, 'SME'), (1, 'default2', 'SME'), (0, '201301', '2013'), (6, NULL, '201312'), (7, '2013', 'default1'), (8, '2013', 'default2'), (9, '2013', '201312'), (10, NULL, 'default1'), (14, '201312', '2013'), (15, '201312', 'default1'), (16, NULL, 'default2'), (17, '201312', '2013'), (18, '201312', 'SME'), (19, 'default2', 'default1'), (20, '201312', '201312'), (21, 'default2', '2013'), (22, 'default2', NULL), (23, '201301', NULL), (24, NULL, '2013'), (25, '201312', 'SME'), (26, '2013', 'SME'), (27, NULL, 'default2'), (28, 'default1', '2013'), (29, 'SME', 'default2'), (30, '2013', 'default1'), (31, '201312', 'SME'), (32, NULL, '201312'), (33, '2013', '201301'), (34, NULL, '201312'), (35, '201301', '2013'), (36, '201312', '2013');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (24, '201301', 11.0), (36, '201312', 5.0), (18, 'default1', 5.0), (3, '201312', 2.0), (16, '2013', 11.0), (25, '201312', 2.0), (13, 'default2', 12.0), (16, '201312', 12.0), (32, '201301', 13.0), (9, '2013', 13.0), (1, '201301', 2.0), (6, 'default1', 3.0), (4, 'default2', 5.0), (34, '201301', 3.0), (4, 'default1', 2.0), (24, '201312', NULL), (4, '2013', 0.0), (30, 'default1', NULL), (28, '2013', 5.0), (1, 'default1', 11.0), (36, 'default2', 1.0), (22, '201301', 13.0), (30, '201312', 2.0), (34, 'default1', 13.0), (33, '201301', 13.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.Consumption) / 12 FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT AVG(y.Consumption) / 12 AS AverageMonthlyConsumption FROM customers AS c INNER JOIN yearmonth AS y ON c.CustomerID = y.CustomerID WHERE c.Segment = 'SME' AND y.Date BETWEEN '201301' AND '201312';

/*
Prediction Result:
(None,)
*/