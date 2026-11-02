-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: SUM vs MAX/MIN/AVG/COUNT, WHERE Segment = 'KAM' filter, GROUP BY CustomerID, ORDER BY SUM(Consumption) DESC, LIMIT 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'USD');
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '202201', 100.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '202202', 150.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '202203', 150.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (2, '202201', 300.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (3, '202201', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' GROUP BY T2.CustomerID ORDER BY SUM(T2.Consumption) DESC, T2.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1, 400.0)
*/

-- Prediction Query
SELECT T1."customerid", MAX(T2."consumption") FROM "customers" AS T1 INNER JOIN "yearmonth" AS T2 ON T1."customerid" = T2."customerid" WHERE T1."segment" = 'KAM' GROUP BY T1."customerid" ORDER BY MAX(T2."consumption") DESC, T1."customerid" NULLS LAST LIMIT 1;

/*
Prediction Result:
(2, 300.0)
*/