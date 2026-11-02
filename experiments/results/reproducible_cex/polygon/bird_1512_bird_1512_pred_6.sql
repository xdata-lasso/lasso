-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '369862', '369862');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 369862, '369862', '369862');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 369862, '369862', '369862');
INSERT INTO "products" ("productid", "description") VALUES (13, '369862');
INSERT INTO "products" ("productid", "description") VALUES (12, '369862');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '2012-08-25', '19', NULL, 21, 22, 23, 24, 25);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (14, '2012-08-25', '26', NULL, 27, 28, 29, 30, 31);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, '17', 369862);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-25' GROUP BY CustomerID ORDER BY SUM(Price) DESC, CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CustomerID FROM transactions_1k WHERE "Date" = '2012-08-25' ORDER BY Amount DESC, transactions_1k.transactionid NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/