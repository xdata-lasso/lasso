-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (34, 'SME', 'CZK');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 34, 'CZK34', 'CZK34');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 34, 'CZK34', 'CZK34');
INSERT INTO "products" ("productid", "description") VALUES (15, 'CZK34');
INSERT INTO "products" ("productid", "description") VALUES (14, 'CZK34');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (24, '1000-01-26', 'EUR26', 34, 27, 28, 29, 655, 30);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (31, '1000-02-02', 'SME33', 34, 35, 36, 37, NULL, 39);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (34, 'EUR17', 34);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (34, 'CZK16', 34);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN c.Currency = 'CZK' THEN t.Amount ELSE 0 END) - SUM(CASE WHEN c.Currency = 'EUR' THEN t.Amount ELSE 0 END) AS AmountDifference FROM customers AS c INNER JOIN transactions_1k AS t ON c.CustomerID = t.CustomerID WHERE c.Segment = 'SME';

/*
Prediction Result:
(655,)
*/