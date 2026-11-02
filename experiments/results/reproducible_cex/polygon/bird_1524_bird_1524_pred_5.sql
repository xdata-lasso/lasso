-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (41, '38', '47');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (31, NULL, '46');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 41, '41', '41');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (43, NULL, '26', NULL);
INSERT INTO "products" ("productid", "description") VALUES (17, '41');
INSERT INTO "products" ("productid", "description") VALUES (16, '41');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (39, '2012-08-24', '40', 41, 42, 43, 44, 54840, -715);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, '1000-01-30', NULL, 31, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (31, '20', 41);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (31, '19', 41);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Amount = 54840 AND T2.Date = '2012-08-24';

/*
Prediction Result:
('47',)
*/