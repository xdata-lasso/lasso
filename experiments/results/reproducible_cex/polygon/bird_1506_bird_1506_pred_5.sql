-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, 'CZE20', 'CZE20');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (38, 39, 'CZE', 'CZE40');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (48, 49, 'CZE', 'CZE50');
INSERT INTO "products" ("productid", "description") VALUES (21, 'CZE20');
INSERT INTO "products" ("productid", "description") VALUES (20, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (32, '1000-02-01', 'CZE33', 34, 35, 38, 20, 36, 37);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (41, '1000-02-12', 'CZE43', 44, 45, 48, 20, 46, 47);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (19, 'CZE23', 20);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (19, 'CZE22', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Country = 'CZE';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT products.description FROM transactions_1k INNER JOIN gasstations ON transactions_1k.gasstationid = gasstations.gasstationid INNER JOIN products ON transactions_1k.productid = products.productid WHERE gasstations.country = 'CZE';

/*
Prediction Result:
(None,)
*/