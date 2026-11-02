-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1001, 'KAM', 'purpose');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1002, 'KAM', 'brother');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1003, 'KAM', 'ago');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1004, 'KAM', 'site');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'face', 1005.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'election', 1012.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'dog', 1019.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'chair', 1026.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' GROUP BY T2.CustomerID ORDER BY SUM(T2.Consumption) DESC, T2.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1001, 4064.0)
*/

-- Prediction Query
SELECT T1."customerid", MAX(T2."consumption") FROM "customers" AS T1 INNER JOIN "yearmonth" AS T2 ON T1."customerid" = T2."customerid" WHERE T1."segment" = 'KAM' GROUP BY T1."customerid" ORDER BY MAX(T2."consumption") DESC, T1."customerid" NULLS LAST LIMIT 1;

/*
Prediction Result:
(1001, 1026.5)
*/