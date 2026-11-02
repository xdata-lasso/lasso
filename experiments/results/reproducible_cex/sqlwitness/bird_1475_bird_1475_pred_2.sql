-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, '201201', 'default1'), (30000, 'KAM', 'KAM'), (2, 'default1', 'default1'), (30001, '201201', '201201'), (0, NULL, 'KAM'), (29999, NULL, 'KAM'), (4, NULL, NULL), (3, 'KAM', '201201'), (5, 'default2', 'default2'), (6, 'KAM', NULL), (7, '2012', 'default1'), (8, '2012', '201212'), (9, 'default2', '2012'), (10, '201212', NULL), (11, 'default1', '201201');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (7, '201212', 30001.0), (30001, 'KAM', 5.0), (9, 'default1', 4.0), (6, 'default1', 2.0), (1, 'KAM', 2.0), (3, '201201', 1.0), (6, '2012', 0.0), (3, 'default1', 29999.0), (29999, 'default1', 0.0), (1, '201201', 30000.0), (4, 'KAM', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "customers"."customerid") FROM "customers" INNER JOIN "yearmonth" ON "customers"."customerid" = "yearmonth"."customerid" WHERE "customers"."segment" = 'KAM' AND "yearmonth"."consumption" < 30000 AND "yearmonth"."date" BETWEEN '201201' AND '201212';

/*
Prediction Result:
(1,)
*/