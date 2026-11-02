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
INSERT INTO "products" ("productid", "description") VALUES (18, NULL);
INSERT INTO "products" ("productid", "description") VALUES (17, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, NULL, NULL, 27, NULL, 29, 18, NULL, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, NULL, NULL, NULL, NULL, NULL, 18, NULL, NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (13, '18', NULL);
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
SELECT p.Description FROM transactions_1k AS t INNER JOIN products AS p ON t.ProductID = p.ProductID GROUP BY p.ProductID, p.Description ORDER BY SUM(t.Amount) DESC, p.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
(None,)
*/