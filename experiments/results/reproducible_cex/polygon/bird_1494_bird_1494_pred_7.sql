-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'SVK12', 'SVK12');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'SVK12', 'SVK12');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 18, 'SVK', 'Premium19');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 12, NULL, 'SVK12');
INSERT INTO "products" ("productid", "description") VALUES (14, 'SVK12');
INSERT INTO "products" ("productid", "description") VALUES (13, 'SVK12');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (16, '1000-01-13', 'SVK12', 12, 12, 12, 12, 12, 12);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '1000-01-13', 'SVK12', 12, 12, 12, 12, 12, 12);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'SVK12', 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Segment = 'Premium', 1, 0)) AS REAL) * 100 / COUNT(GasStationID) FROM gasstations WHERE Country = 'SVK';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN Segment = 'Premium' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(*) AS PremiumPercentage FROM gasstations WHERE Country = 'SVK';

/*
Prediction Result:
(0.0,)
*/