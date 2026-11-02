-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (38508, 'purpose', 'brother');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1001, 1002, 'Anguilla', 'site');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1003, '1970-01-01', 'face', 38508, 1004, 1001, 1005, 1006, 1007.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (38508, '201201', 1008.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Price), SUM(IIF(T3.Date = '201201', T1.Price, 0)) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.CustomerID = '38508';

/*
Gold Result:
(1007.5, 1007.5)
*/

-- Prediction Query
SELECT SUM(T1."amount") AS total_spent_gas_stations, SUM(T2."consumption") AS total_spent_january_2012 FROM "transactions_1k" AS T1 LEFT JOIN "yearmonth" AS T2 ON T1."customerid" = T2."customerid" WHERE T1."customerid" = 38508 AND NOT T1."gasstationid" IS NULL AND T2."date" = '201201';

/*
Prediction Result:
(1006, 1008.5)
*/