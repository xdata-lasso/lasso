-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, NULL, NULL);
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, NULL, NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, NULL, NULL, NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, NULL, NULL, NULL);
INSERT INTO "products" ("productid", "description") VALUES (39, NULL);
INSERT INTO "products" ("productid", "description") VALUES (17, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '1000-01-26', NULL, NULL, NULL, NULL, 39, NULL, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, '1000-02-02', '33', NULL, NULL, NULL, 39, NULL, NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (13, '39', NULL);
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
SELECT p.description FROM products AS p INNER JOIN (SELECT productid, SUM(amount) AS totalsales FROM transactions_1k GROUP BY productid ORDER BY totalsales DESC, productid NULLS LAST LIMIT 5) AS t ON p.productid = t.productid;

/*
Prediction Result:
(None,)
*/