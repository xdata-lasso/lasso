-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, '66746735', '66746735');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (31, '66746752', '66746753');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (35, 36, NULL, '66746737');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (45, 46, NULL, '66746747');
INSERT INTO "products" ("productid", "description") VALUES (20, '66746735');
INSERT INTO "products" ("productid", "description") VALUES (19, '66746735');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (28, '1000-01-30', '66746730', 31, 667467, 35, NULL, NULL, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (38, '1000-02-09', '66746740', NULL, 667467, 45, 42, 43, 44);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (18, '66746723', 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.CardID = 667467;

/*
Prediction Result:
(None,)
*/