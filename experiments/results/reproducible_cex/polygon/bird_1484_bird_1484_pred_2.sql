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
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 18, 'SVK', 'Discount');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 12, 'SVK12', NULL);
INSERT INTO "products" ("productid", "description") VALUES (14, 'SVK12');
INSERT INTO "products" ("productid", "description") VALUES (13, 'SVK12');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (16, '1000-01-13', 'SVK12', 12, 12, 12, 12, 12, 12);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '1000-01-13', 'SVK12', 12, 12, 12, 12, 12, 12);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'SVK12', 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(Country = 'CZE', 1, 0)) - SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations WHERE Segment = 'Discount';

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT SUM(IIF(Country = 'Czech Republic', 1, 0)) - SUM(IIF(Country = 'Slovakia', 1, 0)) FROM gasstations WHERE Segment = 'Discount';

/*
Prediction Result:
(0,)
*/