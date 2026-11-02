-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1001, 'SME', 'CZK');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1002, 'LAM', 'CZK');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1003, 'KAM', 'CZK');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 201306, 1004.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'purpose', 1011.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'brother', 1018.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'ago', 1004.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'site', 1011.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'face', 1018.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(1004.5, 0.0, -1004.5)
*/

-- Prediction Query
SELECT (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) - (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) AS diff1, (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) - (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) AS diff2, (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) - (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) AS diff3;

/*
Prediction Result:
(None, None, None)
*/