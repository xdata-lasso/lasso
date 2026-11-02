-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'SME', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'SME', 'n8c4pgu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'SME', 'e4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'SME', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, 'SME', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 't1__8be681', '5k5swwqcgsk');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, NULL, 'value');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '2013-01-01', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '2013-01-01', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'CAAAA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_3', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_4', 304.02808);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_c80bdd', 475.173408);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (12, '2013-1', 3.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, '2013-1', 2.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '2013-01-01', 582.588439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, 'A31IG', 572.766956);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'AS3GQ', 206.939346);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 5, 2) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME' GROUP BY SUBSTRING(T2.Date, 5, 2) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 5, 2) NULLS LAST LIMIT 1;

/*
Gold Result:
('-0',)
*/

-- Prediction Query
SELECT SUBSTRING(T1.Date, 5, 2) FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Segment = 'SME' AND SUBSTRING(T1.Date, 1, 4) = '2013' ORDER BY T1.Consumption DESC, T1.date NULLS LAST, T1.customerid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
('-0',)
*/