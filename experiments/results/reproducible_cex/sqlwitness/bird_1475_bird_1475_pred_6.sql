-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (2, 'KAM', 'KAM'), (5, 'default1', NULL), (4, 'default1', '2012'), (29999, 'default1', '201212'), (1, 'KAM', '201212'), (30001, '2012', NULL), (30000, 'default1', NULL), (0, '201212', NULL), (3, 'default2', '201201'), (6, NULL, '2012'), (7, '201201', NULL), (8, '2012', '201201'), (9, '2012', 'default2'), (10, 'default1', 'KAM'), (11, '201212', NULL), (12, 'KAM', 'default2'), (13, '201201', 'default1'), (14, '2012', 'default1'), (15, 'default2', 'KAM'), (16, '201201', 'KAM'), (17, 'KAM', '2012'), (18, 'default1', '201201'), (19, NULL, '201201'), (20, 'default2', 'default2'), (21, 'KAM', 'KAM'), (22, 'KAM', 'default2'), (23, '201212', 'KAM'), (24, '201201', '2012'), (25, 'KAM', '201212');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (23, 'default2', 4.0), (3, 'default2', 4.0), (20, '2012', 5.0), (24, '201201', 2.0), (5, '2012', 30001.0), (1, '2012', 5.0), (2, '201201', 29999.0), (1, 'default2', 2.0), (1, '201201', 1.0), (15, 'default1', 30001.0), (21, '2012', 4.0), (3, 'KAM', 5.0), (29999, 'KAM', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(T1.CustomerID) AS count_customers FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1."Date" BETWEEN '201201' AND '201212' AND T2.Segment = 'KAM' AND T1.Consumption < 30000;

/*
Prediction Result:
(2,)
*/