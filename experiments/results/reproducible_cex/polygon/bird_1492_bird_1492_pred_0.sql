-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'KAM', 'EUR19');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, NULL, 'KAM9');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 9, 'KAM9', 'KAM9');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 9, 'KAM9', 'KAM9');
INSERT INTO "products" ("productid", "description") VALUES (14, 'KAM9');
INSERT INTO "products" ("productid", "description") VALUES (13, 'KAM9');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (16, '1000-01-10', 'KAM9', 9, 9, 9, 9, 9, 9);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '1000-01-10', 'KAM9', 9, 9, 9, 9, 9, 9);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'KAM18', 9);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'Euro17', 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(Currency = 'EUR') AS REAL) * 100 / COUNT(CustomerID) FROM customers WHERE Segment = 'KAM';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN Currency = 'Euro' THEN 1 ELSE 0 END) AS REAL) / COUNT(*)) * 100 AS percentage FROM customers WHERE Segment = 'KAM';

/*
Prediction Result:
(0.0,)
*/