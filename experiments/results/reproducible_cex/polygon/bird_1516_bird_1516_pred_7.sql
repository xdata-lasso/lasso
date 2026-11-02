-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (29, 'EUR30', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (37, NULL, 'EUR');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 29, 'CZK29', 'CZK29');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 29, 'CZK29', 'CZK29');
INSERT INTO "products" ("productid", "description") VALUES (18, 'CZK29');
INSERT INTO "products" ("productid", "description") VALUES (17, 'CZK29');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (23, '2012-08-26', 'EUR142', 29, 24, 25, 26, 27, 28);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (31, '2012-08-26', 'CZK-715', 37, NULL, NULL, 34, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-26' AND T1.Time < '13:00:00' AND T2.Currency = 'EUR';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.TransactionID) AS TransactionCount FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-26' AND T1.Time < '13:00:00' AND T2.Currency = 'CZK';

/*
Prediction Result:
(0,)
*/