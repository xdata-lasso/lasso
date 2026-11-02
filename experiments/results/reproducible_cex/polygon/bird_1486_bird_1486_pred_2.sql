-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (30, 'SME', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (36, 'Euro19', NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 30, 'SME30', 'SME30');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 30, 'SME30', 'SME30');
INSERT INTO "products" ("productid", "description") VALUES (15, 'SME30');
INSERT INTO "products" ("productid", "description") VALUES (14, 'SME30');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (27, '1000-01-29', 'Euro29', 30, 31, 32, 33, 34, 35);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (16, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (36, 'Czech Koruna18', 30);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (36, 'EUR17', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT SUM(IIF(T1.Currency = 'Czech Koruna', 1, 0)) - SUM(IIF(T1.Currency = 'Euro', 1, 0)) AS MoreSMEs FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME';

/*
Prediction Result:
(0,)
*/