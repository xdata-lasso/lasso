-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'Premium11', 'Premium11');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 19, 'CZE', 'Premium');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 11, NULL, NULL);
INSERT INTO "products" ("productid", "description") VALUES (13, 'Premium11');
INSERT INTO "products" ("productid", "description") VALUES (12, 'Premium11');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '1000-01-12', 'Premium11', 11, 11, 11, 11, 11, 11);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (14, '1000-01-12', 'Premium11', 11, 11, 11, 11, 11, 11);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'Premium17', 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(GasStationID) FROM gasstations WHERE Country = 'CZE' AND Segment = 'Premium';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM gasstations WHERE Country = 'CZE' AND Segment = 'Premium';

/*
Prediction Result:
(1,)
*/