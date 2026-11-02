-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (-1, '2012%', 'SME'), (100, '2013', 'default1'), (99, 'default2', 'SME'), (4, 'SME', 'EUR'), (0, 'SME', '2013%'), (3, 'SME', '2013%');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (3, 'default1', 100.0), (4, 'default2', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0))) AS REAL) * 100 / SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID;

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
SELECT "segment", MAX(percentage_increase) AS max_increase, MIN(percentage_increase) AS min_increase FROM (SELECT c."segment", ((SUM(CASE WHEN SUBSTRING(y."date", 1, 4) = '2013' THEN y."consumption" ELSE 0 END) - SUM(CASE WHEN SUBSTRING(y."date", 1, 4) = '2012' THEN y."consumption" ELSE 0 END)) / SUM(CASE WHEN SUBSTRING(y."date", 1, 4) = '2013' THEN y."consumption" ELSE 0 END)) * 100 AS percentage_increase FROM "customers" AS c JOIN "yearmonth" AS y ON c."customerid" = y."customerid" WHERE c."currency" = 'EUR' AND c."segment" IN ('SME', 'LAM', 'KAM') GROUP BY c."segment");

/*
Prediction Result:
('SME', None, None)
*/