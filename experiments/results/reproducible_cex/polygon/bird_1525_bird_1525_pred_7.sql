-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, NULL, NULL);
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, 'EUR16', 'EUR16');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (18, 16, 'EUR16', 'EUR16');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, 16, 'EUR16', 'EUR16');
INSERT INTO "products" ("productid", "description") VALUES (20, 'EUR16');
INSERT INTO "products" ("productid", "description") VALUES (19, 'EUR16');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (28, '2012-08-25', 'EUR29', 16, 30, 31, 32, 33, 34);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '1000-02-07', NULL, 16, NULL, NULL, NULL, NULL, 43);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (15, 'EUR23', 16);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (15, 'EUR22', 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SUM(IIF(T2.Currency = 'EUR', 1, 0)) * 100.0 / COUNT(*)) AS PercentageEUR FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Prediction Result:
(0.0,)
*/