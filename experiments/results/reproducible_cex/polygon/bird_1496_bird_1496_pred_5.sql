-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (26, NULL, '20130928');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (30, NULL, '20130932');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 26, '20130926', '20130926');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 26, '20130926', '20130926');
INSERT INTO "products" ("productid", "description") VALUES (18, '20130926');
INSERT INTO "products" ("productid", "description") VALUES (17, '20130926');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-01-27', '20130926', 26, 26, 26, 26, 26, 26);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '1000-01-27', '20130926', 26, 26, 26, 26, 26, 26);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (26, '201309', 25);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (30, '201309', 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT c.segment FROM yearmonth AS y INNER JOIN customers AS c ON y.customerid = c.customerid WHERE y.date = '201309' GROUP BY c.segment ORDER BY SUM(y.consumption) ASC, c.segment NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/