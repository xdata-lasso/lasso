-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, '20120863', '20120863');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (63, '20120863', '20120863');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 63, '20120863', '20120863');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 63, '20120863', '20120863');
INSERT INTO "products" ("productid", "description") VALUES (18, '20120863');
INSERT INTO "products" ("productid", "description") VALUES (17, '20120863');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-01-26', '20120826', 63, 27, 28, 5, 7026, 210780);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '1000-01-30', '20120831', 63, 32, 33, 5, 1, 210780);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (14, '20120863', 63);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (63, '201208', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Price / T1.Amount > 29.00 AND T1.ProductID = 5 AND T2.Date = '201208';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT Consumption FROM yearmonth WHERE Date = '201208' AND CustomerID IN (SELECT CustomerID FROM transactions_1k WHERE ProductID = 5 AND (Price / Amount) > 29.0);

/*
Prediction Result:
(None,)
*/