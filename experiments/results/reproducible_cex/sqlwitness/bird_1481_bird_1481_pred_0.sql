-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (201311, 'default1', 'SME'), (1, 'KAM', '201312'), (201300, 'default2', 'default1'), (-1, '201312', '201312'), (0, '201312', NULL), (201302, '201301', 'CZK'), (201312, 'default2', '201312'), (201301, NULL, '201312'), (201313, 'default1', 'default2'), (2, '201301', '201301'), (3, 'default2', NULL), (4, 'LAM', NULL), (5, 'SME', 'default1'), (6, 'LAM', '201301'), (7, 'default1', '201312'), (8, 'default2', 'SME'), (9, 'SME', '201301'), (10, 'default2', '201301'), (11, 'KAM', NULL), (12, 'SME', '201301'), (13, 'default1', 'CZK'), (14, 'CZK', 'CZK');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (201302, '201312', 1.0), (10, 'SME', 201300.0), (7, 'default1', 201311.0), (10, '201301', NULL), (-1, 'SME', 1.0), (1, 'LAM', 201300.0), (201301, 'default2', 201311.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(0.0, 0.0, 0.0)
*/

-- Prediction Query
WITH Consumption_CZK AS (SELECT "customers"."segment", "yearmonth"."customerid", SUM("yearmonth"."consumption") AS total_consumption FROM "yearmonth" INNER JOIN "customers" ON "yearmonth"."customerid" = "customers"."customerid" WHERE "customers"."currency" = 'CZK' AND "yearmonth"."date" BETWEEN '201301' AND '201312' GROUP BY "customers"."segment", "yearmonth"."customerid"), Min_Consumption AS (SELECT "segment", MIN(total_consumption) AS min_consumption FROM Consumption_CZK GROUP BY "segment"), Annual_Average AS (SELECT C."segment", C.total_consumption / COUNT(C."customerid") AS annual_average FROM Consumption_CZK AS C INNER JOIN Min_Consumption AS M ON C."segment" = M."segment" AND C.total_consumption = M.min_consumption GROUP BY C."segment") SELECT (SELECT annual_average FROM Annual_Average WHERE "segment" = 'SME') - (SELECT annual_average FROM Annual_Average WHERE "segment" = 'LAM') AS SME_LAM_diff, (SELECT annual_average FROM Annual_Average WHERE "segment" = 'LAM') - (SELECT annual_average FROM Annual_Average WHERE "segment" = 'KAM') AS LAM_KAM_diff, (SELECT annual_average FROM Annual_Average WHERE "segment" = 'KAM') - (SELECT annual_average FROM Annual_Average WHERE "segment" = 'SME') AS KAM_SME_diff;

/*
Prediction Result:
(None, None, None)
*/