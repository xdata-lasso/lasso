-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, 'CZE40', 'CZE40');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, 'CZE40', 'CZE40');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, 20, 'CZE', 'Premium');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (40, 34, 'CZE', 'Premium');
INSERT INTO "products" ("productid", "description") VALUES (19, 'Premium45');
INSERT INTO "products" ("productid", "description") VALUES (18, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (27, '1000-01-29', 'Premium29', 30, 31, 40, 18, 32, 33);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (35, '1000-02-06', 'Premium37', 38, 39, 40, 19, 41, 42);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (16, 'CZE40', 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(GasStationID) FROM gasstations WHERE Country = 'CZE' AND Segment = 'Premium';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT g.GasStationID) FROM gasstations AS g JOIN transactions_1k AS t ON g.GasStationID = t.GasStationID JOIN products AS p ON t.ProductID = p.ProductID WHERE g.Country = 'CZE' AND (p.Description = 'Premium' OR g.Segment = 'Premium');

/*
Prediction Result:
(1,)
*/