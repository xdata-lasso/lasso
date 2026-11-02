-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2012-08-24', 'default2', NULL, 1, 1, 0, 0, NULL), (0, '2012-08-25', 'default1', NULL, 0, NULL, 1, 1, 1.0), (2, NULL, NULL, NULL, 0, NULL, NULL, 0, 0.0), (3, '2012-08-24', 'default2', 1, 0, 1, NULL, 1, 548.4), (4, '2012-08-24', NULL, 0, 0, NULL, NULL, NULL, 548.4), (5, NULL, 'default1', NULL, NULL, 0, 1, 0, 548.4), (6, NULL, 'default1', 0, NULL, 0, 0, 0, 549.4);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 1, NULL, 'default2'), (0, NULL, '2012-08-24', NULL), (2, 0, NULL, '2012-08-24'), (3, 1, '2012-08-24', 'default1'), (4, 1, 'default1', '2012-08-24'), (5, NULL, 'default2', NULL), (6, 0, 'default2', 'default1'), (7, 0, NULL, 'default1'), (8, 1, '2012-08-24', 'default1'), (9, NULL, '2012-08-24', NULL), (10, 1, '2012-08-24', '2012-08-24'), (11, NULL, 'default2', 'default2'), (12, NULL, 'default2', '2012-08-24'), (13, 0, '2012-08-24', 'default1'), (14, 0, 'default1', '2012-08-24'), (15, 1, NULL, 'default1'), (16, 0, NULL, 'default1'), (17, 0, 'default2', 'default1'), (18, 0, 'default1', 'default1'), (19, 0, 'default2', 'default2'), (20, NULL, NULL, '2012-08-24'), (21, 0, 'default2', 'default2'), (22, 0, '2012-08-24', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT "g"."country" FROM "transactions_1k" AS "t" INNER JOIN "gasstations" AS "g" ON "t"."gasstationid" = "g"."gasstationid" WHERE "t"."amount" = 548.4 AND "t"."date" = '2012-08-24';

/*
Prediction Result:
*/