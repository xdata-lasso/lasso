-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'SVK9', 'SVK9');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'SVK9', 'SVK9');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 17, 'Slovakia', 'Premium');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, NULL, 'SVK', NULL);
INSERT INTO "products" ("productid", "description") VALUES (14, 'SVK9');
INSERT INTO "products" ("productid", "description") VALUES (13, 'SVK9');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (16, '1000-01-10', 'SVK9', 9, 9, 9, 9, 9, 9);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '1000-01-10', 'SVK9', 9, 9, 9, 9, 9, 9);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, 'SVK9', 9);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'SVK9', 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Segment = 'Premium', 1, 0)) AS REAL) * 100 / COUNT(GasStationID) FROM gasstations WHERE Country = 'SVK';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN Segment = 'Premium' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(GasStationID) FROM gasstations WHERE Country = 'Slovakia';

/*
Prediction Result:
(100.0,)
*/