-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1137, 'base', 'top');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1147, 'fall', 'long');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1138, '1997-06-05', 'early', 1137, 1139, 1140, 5, 1000, 30000.0);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1143, '1998-07-06', 'husband', 1137, 1144, 1145, 5, 1000, 30000.0);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1148, '1970-08-07', 'prove', 1147, 1149, 1150, 5, 1000, 30000.0);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1137, '201208', 1141.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1147, '201208', 1151.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Price / T1.Amount > 29.00 AND T1.ProductID = 5 AND T2.Date = '201208';

/*
Gold Result:
(1141.5,)
(1141.5,)
(1151.5,)
*/

-- Prediction Query
SELECT Consumption FROM yearmonth WHERE Date = '201208' AND CustomerID IN (SELECT CustomerID FROM transactions_1k WHERE ProductID = 5 AND (Price / Amount) > 29.0);

/*
Prediction Result:
(1141.5,)
(1151.5,)
*/