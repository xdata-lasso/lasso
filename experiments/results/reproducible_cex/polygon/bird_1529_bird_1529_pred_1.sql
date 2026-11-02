-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, '38508', '38508');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (38508, '38508', '38508');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (44, 26, '20120127', '3850828');
INSERT INTO "products" ("productid", "description") VALUES (20, '38508');
INSERT INTO "products" ("productid", "description") VALUES (19, '38508');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (40, NULL, NULL, 38508, NULL, 44, NULL, 6513, -80);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (38508, '201201', 46);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (38508, '20120121', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Price), SUM(IIF(T3.Date = '201201', T1.Price, 0)) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.CustomerID = '38508';

/*
Gold Result:
(-160.0, -80.0)
*/

-- Prediction Query
SELECT SUM(T1.Amount), T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.CustomerID = 38508 AND T2.Date = '201201';

/*
Prediction Result:
(6513, 46.0)
*/