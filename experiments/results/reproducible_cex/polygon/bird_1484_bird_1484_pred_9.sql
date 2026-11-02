-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'CZE10', 'CZE10');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'CZE10', 'CZE10');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 10, 'CZE', NULL);
INSERT INTO "products" ("productid", "description") VALUES (12, 'CZE10');
INSERT INTO "products" ("productid", "description") VALUES (11, 'CZE10');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (14, '1000-01-11', 'CZE10', 10, 10, 10, 10, 10, 10);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (13, '1000-01-11', 'CZE10', 10, 10, 10, 10, 10, 10);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'CZE10', 10);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, 'CZE10', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(Country = 'CZE', 1, 0)) - SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations WHERE Segment = 'Discount';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN T1.Country = 'CZE' AND T1.Segment = 'Discount' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.Country = 'SVK' AND T1.Segment = 'Discount' THEN 1 ELSE 0 END) FROM gasstations AS T1;

/*
Prediction Result:
(0,)
*/