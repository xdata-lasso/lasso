-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, 'CZE17', 'CZE17');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, 'CZE17', 'CZE17');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, 32, 'CZE', 'CZE33');
INSERT INTO "products" ("productid", "description") VALUES (19, 'CZE17');
INSERT INTO "products" ("productid", "description") VALUES (18, 'CZE17');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '1000-01-27', 'CZE27', 28, 29, 17, 30, 31, 1001);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, NULL, NULL, NULL, NULL, 17, NULL, NULL, -722);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (16, 'CZE17', 17);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (15, 'CZE17', 17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND T1.Price > 1000;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND T1.Price > 1000;

/*
Prediction Result:
(1,)
*/