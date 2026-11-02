-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, NULL, 'LAM31');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (31, 'LAM', NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (20, 31, 'LAM31', 'LAM31');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (19, 31, 'LAM31', 'LAM31');
INSERT INTO "products" ("productid", "description") VALUES (22, 'LAM31');
INSERT INTO "products" ("productid", "description") VALUES (21, 'LAM31');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (24, '1000-02-01', 'LAM31', 31, 31, 31, 31, 31, 31);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (23, '1000-02-01', 'LAM31', 31, 31, 31, 31, 31, 31);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (31, 'LAM32', 47);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (31, 'LAM33', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Consumption > 46.73, 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT (COUNT(DISTINCT y."customerid") * 100.0 / (SELECT COUNT(DISTINCT c."customerid") FROM "customers" AS c WHERE c."segment" = 'LAM')) AS percentage FROM "yearmonth" AS y INNER JOIN "customers" AS c ON y."customerid" = c."customerid" WHERE c."segment" = 'LAM' AND y."consumption" > 46.73;

/*
Prediction Result:
(100.0,)
*/