-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, '29', '29');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, '29', '29');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 29, '29', '29');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (29, 34, '35', '36');
INSERT INTO "products" ("productid", "description") VALUES (17, '29');
INSERT INTO "products" ("productid", "description") VALUES (16, '29');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '2012-08-23', '76800', 25, 26, 24, NULL, 27, 28);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, '2012-08-23', '76800', 30, 31, 29, NULL, 32, 33);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (14, '29', 29);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (13, '29', 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ProductID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-23' AND T1.Time = '21:20:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.ProductID FROM "transactions_1k" AS T1 WHERE T1.Date = '2012-08-23' AND T1.Time = '21:20:00';

/*
Prediction Result:
*/