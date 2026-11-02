-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, '66746730', '66746730');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, NULL, '66746742');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (30, 31, '66746740', '66746732');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 30, '66746730', '66746730');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (23, NULL, NULL, 26, 667467, 30, NULL, NULL, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, NULL, NULL, 13, 36, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
('66746740',)
*/

-- Prediction Query
SELECT customers.Currency FROM transactions_1k INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.CardID = 667467;

/*
Prediction Result:
*/