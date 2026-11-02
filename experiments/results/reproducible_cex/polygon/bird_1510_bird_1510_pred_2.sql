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
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (18, 17, 'CZE17', 'CZE17');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, 29, 'CZE', 'CZE30');
INSERT INTO "products" ("productid", "description") VALUES (20, 'CZE17');
INSERT INTO "products" ("productid", "description") VALUES (19, 'CZE17');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (22, '1000-01-18', 'CZE17', 17, 17, NULL, 17, 17, 17);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '1000-02-01', 'CZE32', 33, 34, 17, 35, NULL, -122);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (16, 'CZE24', 17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Gold Result:
(-122.0,)
*/

-- Prediction Query
SELECT AVG(T2.Amount * T2.Price) FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Country = 'CZE';

/*
Prediction Result:
(None,)
*/