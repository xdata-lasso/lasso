-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (28, 'SME', 'SME24');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, 'SME', 'EUR');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 28, 'CZK28', 'CZK28');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 28, 'CZK28', 'CZK28');
INSERT INTO "products" ("productid", "description") VALUES (16, 'CZK28');
INSERT INTO "products" ("productid", "description") VALUES (15, 'CZK28');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (25, '1000-01-27', 'SME27', 28, 29, 30, 31, 32, 33);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (12, 'CZK28', 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN T1.Currency = 'CZK' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.Currency = 'EUR' THEN 1 ELSE 0 END) FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME';

/*
Prediction Result:
(0,)
*/