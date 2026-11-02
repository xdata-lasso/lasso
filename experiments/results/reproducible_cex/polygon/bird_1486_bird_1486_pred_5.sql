-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (20, 'SME', 'CZK');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, 'SME', 'CZK');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (22, 19, 'CZK19', 'CZK19');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (21, 19, 'CZK19', 'CZK19');
INSERT INTO "products" ("productid", "description") VALUES (24, 'CZK19');
INSERT INTO "products" ("productid", "description") VALUES (23, 'CZK19');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (25, NULL, NULL, 19, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (19, 'CZK19', 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT (czk_count - eur_count) AS difference FROM (SELECT COUNT(*) AS czk_count FROM transactions_1k AS t INNER JOIN customers AS c ON t.customerid = c.customerid WHERE c.currency = 'CZK' AND c.segment = 'SME') AS czk CROSS JOIN (SELECT COUNT(*) AS eur_count FROM transactions_1k AS t INNER JOIN customers AS c ON t.customerid = c.customerid WHERE c.currency = 'EUR' AND c.segment = 'SME') AS eur;

/*
Prediction Result:
(1,)
*/