-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, '20130647', '20130647');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (23, '20130647', '20130647');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (20, 47, '20130647', '20130647');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (47, 40, NULL, '20130642');
INSERT INTO "products" ("productid", "description") VALUES (22, '20130647');
INSERT INTO "products" ("productid", "description") VALUES (21, '20130647');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (33, '1000-02-04', '20130635', 23, 36, 47, 37, 38, 39);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (43, '1000-02-14', '20130645', 23, NULL, 47, 48, 49, 50);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (23, '20130624', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (23, '201306', 32);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT gasstations.Country FROM gasstations INNER JOIN transactions_1k ON gasstations.GasStationID = transactions_1k.GasStationID INNER JOIN yearmonth ON transactions_1k.CustomerID = yearmonth.CustomerID WHERE yearmonth.Date = '201306';

/*
Prediction Result:
(None,)
*/