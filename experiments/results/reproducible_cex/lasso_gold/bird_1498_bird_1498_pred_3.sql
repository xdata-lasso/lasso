-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1001, 'purpose', 'face');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1002, 'brother', 'election');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1003, 'ago', 'dog');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1004, 'site', 'chair');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, '201201', 1005.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1002, '201201', 1012.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1003, '201201', 1019.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1004, '201201', 1026.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Consumption) FROM yearmonth WHERE SUBSTRING(Date, 1, 4) = '2012' GROUP BY SUBSTRING(Date, 5, 2) ORDER BY SUM(Consumption) DESC LIMIT 1;

/*
Gold Result:
(4064.0,)
*/

-- Prediction Query
SELECT MAX(yearmonth.consumption) AS highestmonthlyconsumption FROM yearmonth WHERE SUBSTRING(yearmonth.date, 1, 4) = '2012';

/*
Prediction Result:
(1026.5,)
*/