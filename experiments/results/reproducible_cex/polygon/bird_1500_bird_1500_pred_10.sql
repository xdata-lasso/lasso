-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (23, '20130923', '20130923');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, '20130923', '20130923');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (21, 23, '20130923', '20130923');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (20, 23, '20130923', '20130923');
INSERT INTO "products" ("productid", "description") VALUES (46, '20130940');
INSERT INTO "products" ("productid", "description") VALUES (22, '20130923');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (33, NULL, NULL, 23, NULL, NULL, 46, NULL, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (41, NULL, NULL, 23, 44, 45, 46, NULL, NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (23, '201309', 29);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (23, '20130924', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('20130940',)
('20130940',)
*/

-- Prediction Query
SELECT DISTINCT "products"."description" FROM "products" INNER JOIN "transactions_1k" ON "products"."productid" = "transactions_1k"."productid" INNER JOIN "yearmonth" ON "transactions_1k"."customerid" = "yearmonth"."customerid" WHERE "yearmonth"."date" = '201309';

/*
Prediction Result:
('20130940',)
*/