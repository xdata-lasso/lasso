-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (27, NULL, '20130926');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (31, NULL, '20130930');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 27, '20130927', '20130927');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 27, '20130927', '20130927');
INSERT INTO "products" ("productid", "description") VALUES (18, '20130927');
INSERT INTO "products" ("productid", "description") VALUES (17, '20130927');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-01-28', '20130927', 27, 27, 27, 27, 27, 27);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '1000-01-28', '20130927', 27, 27, 27, 27, 27, 27);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (27, '201309', 28);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (31, '201309', 32);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT c.Segment FROM customers AS c INNER JOIN yearmonth AS ym ON c.CustomerID = ym.CustomerID WHERE ym.Date = '201309' GROUP BY c.Segment ORDER BY SUM(ym.Consumption) ASC, c.Segment NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/