-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (22, 'CZE49', 'CZE49');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (23, 49, 'CZE49', 'CZE49');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (49, 42, 'CZE', 'CZE43');
INSERT INTO "products" ("productid", "description") VALUES (25, NULL);
INSERT INTO "products" ("productid", "description") VALUES (24, 'CZE49');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (35, '1000-02-06', 'CZE37', 38, 39, 49, 25, 40, 41);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (44, '1000-02-15', 'CZE46', 47, 48, 49, 25, 50, 51);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (22, 'CZE27', 49);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (22, 'CZE26', 49);
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
SELECT DISTINCT T3.Description FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN products AS T3 ON T2.ProductID = T3.ProductID WHERE T1.Country = 'CZE';

/*
Prediction Result:
(None,)
*/