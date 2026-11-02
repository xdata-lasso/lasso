-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (5, NULL, 'KAM'), (30001, 'default2', 'default1'), (3, 'KAM', NULL), (30000, '2012', 'KAM'), (0, 'default1', 'KAM'), (29999, NULL, '2012'), (2, 'default2', NULL), (1, NULL, '201212'), (4, NULL, '201212'), (6, 'default2', '201201'), (7, '201201', 'default2'), (8, '201201', '201212'), (9, NULL, '201212'), (10, 'KAM', NULL), (11, 'KAM', NULL), (12, '201201', 'KAM'), (13, '201212', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, 'default2', 2.0), (13, 'default2', 4.0), (3, '2012', 5.0), (0, '201201', 4.0), (29999, 'default2', NULL), (13, 'default1', 29999.0), (9, '201212', 5.0), (30000, '201201', 3.0), (6, 'KAM', 30000.0), (12, 'default1', 30000.0), (2, 'KAM', 30001.0), (11, 'default2', 30000.0), (30000, 'KAM', 30001.0), (6, 'default1', 30001.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT CustomerID) FROM yearmonth WHERE Date BETWEEN '201201' AND '201212' AND Consumption < 30000 AND CustomerID IN (SELECT CustomerID FROM customers WHERE Segment = 'KAM');

/*
Prediction Result:
(0,)
*/