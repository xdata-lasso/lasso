-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (66, '20120866', '20120866');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (17, '20120866', '20120866');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (19, 66, '20120866', '20120866');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (18, 66, '20120866', '20120866');
INSERT INTO "products" ("productid", "description") VALUES (21, '20120866');
INSERT INTO "products" ("productid", "description") VALUES (20, '20120866');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (23, '1000-01-29', '20120829', 66, 31, 32, 5, 2, 60);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (22, '1000-02-03', '20120834', 66, 35, 36, 5, 1, 60);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (66, '201208', 67);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (17, '20120866', 66);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Price / T1.Amount > 29.00 AND T1.ProductID = 5 AND T2.Date = '201208';

/*
Gold Result:
(67.0,)
(67.0,)
*/

-- Prediction Query
SELECT T1.Consumption FROM yearmonth AS T1 INNER JOIN (SELECT DISTINCT CustomerID FROM transactions_1k WHERE ProductID = 5 AND Price / Amount > 29) AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201208';

/*
Prediction Result:
(67.0,)
*/