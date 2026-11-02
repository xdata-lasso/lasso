-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (22, '20130625', '20130625');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (25, '20130625', '20130625');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (42, 43, '20130644', '20130645');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (53, 54, '20130644', '20130655');
INSERT INTO "products" ("productid", "description") VALUES (24, '20130625');
INSERT INTO "products" ("productid", "description") VALUES (23, '20130625');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (35, '1000-02-06', '20130637', 25, 38, 42, 39, 40, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (46, '1000-02-17', '20130648', 25, 49, 53, 50, 51, 52);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (25, '20130626', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (25, '201306', 34);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('20130644',)
('20130644',)
*/

-- Prediction Query
SELECT DISTINCT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Prediction Result:
('20130644',)
*/