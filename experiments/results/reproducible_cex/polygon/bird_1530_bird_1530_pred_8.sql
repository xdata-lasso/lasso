-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (11, '31', '31');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 31, '31', '31');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 31, '31', '31');
INSERT INTO "products" ("productid", "description") VALUES (14, '31');
INSERT INTO "products" ("productid", "description") VALUES (31, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (16, '1000-01-24', '24', 25, 26, 27, 31, 28, 29);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '1000-02-02', '33', 34, NULL, NULL, 31, NULL, NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (11, '18', 31);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (11, '17', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT "products"."description" FROM "products" INNER JOIN "transactions_1k" ON "products"."productid" = "transactions_1k"."productid" GROUP BY "products"."description" ORDER BY SUM("transactions_1k"."amount") DESC, "products"."description" NULLS LAST LIMIT 5;

/*
Prediction Result:
(None,)
*/