-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (24, NULL, '20130926');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (28, NULL, '20130930');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 24, '20130924', '20130924');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 24, '20130924', '20130924');
INSERT INTO "products" ("productid", "description") VALUES (16, '20130924');
INSERT INTO "products" ("productid", "description") VALUES (15, '20130924');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, '1000-01-25', '20130924', 24, 24, 24, 24, 24, 24);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (17, '1000-01-25', '20130924', 24, 24, 24, 24, 24, 24);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (24, '201309', 23);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (28, '201309', 27);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT "customers"."segment" FROM "yearmonth" INNER JOIN "customers" ON "yearmonth"."customerid" = "customers"."customerid" WHERE "yearmonth"."date" = '201309' GROUP BY "customers"."segment" ORDER BY SUM("yearmonth"."consumption") ASC, "customers"."segment" NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/