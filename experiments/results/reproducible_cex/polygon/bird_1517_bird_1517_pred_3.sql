-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, NULL, '34');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (20, NULL, NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 20, '20', '20');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 20, '20', '20');
INSERT INTO "products" ("productid", "description") VALUES (16, '20');
INSERT INTO "products" ("productid", "description") VALUES (15, '20');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, '1000-01-28', '28', 20, 29, 30, 31, 32, 33);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (17, '1000-01-21', '20', NULL, 20, 20, 20, 20, 20);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (20, '22', 39);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (19, '21', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY T2.Date, T1.customerid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/