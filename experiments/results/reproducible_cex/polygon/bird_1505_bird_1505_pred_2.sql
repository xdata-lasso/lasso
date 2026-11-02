-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (30, 'euro29', 'euro');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (21, NULL, 'EUR28');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 30, 'EUR30', 'EUR30');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 30, 'EUR30', 'EUR30');
INSERT INTO "products" ("productid", "description") VALUES (18, 'EUR30');
INSERT INTO "products" ("productid", "description") VALUES (17, 'EUR30');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-01-31', 'EUR30', 30, 30, 30, 30, 30, 30);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '1000-01-31', 'EUR30', 30, 30, 30, 30, 30, 30);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (30, 'euro31', 1001);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (21, 'EUR22', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' AND T1.Consumption > 1000.00;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'euro' AND T2.Consumption > 1000;

/*
Prediction Result:
(1,)
*/