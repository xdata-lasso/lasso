-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, '3850836', '3850836');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (38508, '3850836', '3850836');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (36, 42, '20120143', NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (20, 36, '3850836', '3850836');
INSERT INTO "products" ("productid", "description") VALUES (22, '3850836');
INSERT INTO "products" ("productid", "description") VALUES (21, '3850836');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (24, '1000-01-30', '3850830', NULL, 32, 36, 33, 34, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (23, NULL, NULL, 38508, NULL, 36, NULL, NULL, -1);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (19, '3850836', 36);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (38508, '201201', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Price), SUM(IIF(T3.Date = '201201', T1.Price, 0)) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.CustomerID = '38508';

/*
Gold Result:
(-1.0, -1.0)
*/

-- Prediction Query
SELECT SUM(T1."amount") AS total_spent_gas_stations, SUM(T2."consumption") AS total_spent_january_2012 FROM "transactions_1k" AS T1 LEFT JOIN "yearmonth" AS T2 ON T1."customerid" = T2."customerid" WHERE T1."customerid" = 38508 AND NOT T1."gasstationid" IS NULL AND T2."date" = '201201';

/*
Prediction Result:
(None, 1.0)
*/