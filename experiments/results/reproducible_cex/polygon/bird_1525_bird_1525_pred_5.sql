-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (31, 'EUR32', 'EUR33');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (36, NULL, NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 31, 'EUR31', 'EUR31');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 31, 'EUR31', 'EUR31');
INSERT INTO "products" ("productid", "description") VALUES (18, 'EUR31');
INSERT INTO "products" ("productid", "description") VALUES (17, 'EUR31');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (24, '2012-08-25', 'EUR25', 31, 26, 27, 28, 29, 30);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, NULL, NULL, 36, NULL, 40, NULL, NULL, NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (36, 'EUR31', 31);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (31, 'EUR31', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.Currency = 'EUR' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '2012-08-25';

/*
Prediction Result:
(0.0,)
*/