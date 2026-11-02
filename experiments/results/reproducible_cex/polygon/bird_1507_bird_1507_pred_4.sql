-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (17, '44', '44');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, '44', '44');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (30, 11, '24', '25');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (40, 11, '34', '35');
INSERT INTO "products" ("productid", "description") VALUES (19, '44');
INSERT INTO "products" ("productid", "description") VALUES (18, '44');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (26, '1000-01-28', '44', 28, 29, 30, 31, 32, 33);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (36, '1000-02-07', '44', 38, 39, 40, 41, 42, 43);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (16, '44', 44);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.Time FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.ChainID = 11;

/*
Gold Result:
('44',)
*/

-- Prediction Query
SELECT T2.Time FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ChainID = 11;

/*
Prediction Result:
('44',)
('44',)
*/