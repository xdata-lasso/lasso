-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (17, '36', '27');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, '36', '28');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (19, 16, '16', '16');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (18, 16, '16', '16');
INSERT INTO "products" ("productid", "description") VALUES (21, '16');
INSERT INTO "products" ("productid", "description") VALUES (20, '16');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (22, '1000-01-30', '30', 16, 31, 32, 33, 34, 35);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (17, '16', 16);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (16, '16', 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
('36',)
*/

-- Prediction Query
SELECT c.segment FROM customers AS c WHERE c.customerid = (SELECT t.customerid FROM transactions_1k AS t ORDER BY t.date ASC, t.transactionid NULLS LAST LIMIT 1);

/*
Prediction Result:
('36',)
*/