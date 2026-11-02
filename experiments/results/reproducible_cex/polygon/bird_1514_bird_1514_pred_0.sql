-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (41, '39', '47');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, '41', '41');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (43, 28, '29', '30');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (19, 41, '41', '41');
INSERT INTO "products" ("productid", "description") VALUES (21, '41');
INSERT INTO "products" ("productid", "description") VALUES (20, '41');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (33, '2012-08-24', '59100', 41, 34, 35, 36, 37, 38);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (40, '2012-08-24', '59100', 41, 42, 43, 44, 45, 46);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (18, '23', 41);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (18, '22', 41);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Currency FROM customers AS T1 INNER JOIN "transactions_1k" AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '2012-08-24' AND T2.Time = '16:25:00';

/*
Prediction Result:
*/