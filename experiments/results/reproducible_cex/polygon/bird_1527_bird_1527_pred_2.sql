-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, '34', '34');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, '34', '34');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 34, '34', '34');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (34, 26, '27', '28');
INSERT INTO "products" ("productid", "description") VALUES (17, '34');
INSERT INTO "products" ("productid", "description") VALUES (16, '34');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, '1000-02-04', '34', 34, 34, NULL, 34, 34, 34);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (29, '1000-01-31', '31', 32, 33, 34, 35, 36, 37);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (14, '20', 34);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (13, '19', 34);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT GasStationID FROM transactions_1k GROUP BY GasStationID ORDER BY SUM(Price) DESC, GasStationID NULLS LAST LIMIT 1;

/*
Gold Result:
(34,)
*/

-- Prediction Query
SELECT T2.GasStationID FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE NOT T2.Amount IS NULL AND NOT T2.Price IS NULL GROUP BY T2.GasStationID ORDER BY SUM(T2.Amount * T2.Price) DESC, T2.GasStationID NULLS LAST LIMIT 1;

/*
Prediction Result:
(34,)
*/