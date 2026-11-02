-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, '66746744', '66746744');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, '66746744', '66746744');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (31, 32, '66746744', '66746733');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (41, 42, '66746744', '66746743');
INSERT INTO "products" ("productid", "description") VALUES (17, '66746744');
INSERT INTO "products" ("productid", "description") VALUES (16, '66746744');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (24, '1000-01-26', '66746726', 27, 667467, 31, 28, 29, 30);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (34, '1000-02-05', '66746736', 37, 667467, 41, 38, 39, 40);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (15, '66746719', 44);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (15, '66746718', 44);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
('66746744',)
('66746744',)
*/

-- Prediction Query
SELECT DISTINCT "gasstations"."country" FROM "transactions_1k" INNER JOIN "gasstations" ON "transactions_1k"."gasstationid" = "gasstations"."gasstationid" WHERE "transactions_1k"."cardid" = 667467;

/*
Prediction Result:
('66746744',)
*/