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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'SME', 'n8c4pgu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 't1__6f7677', '5k5swwqcgsk');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, NULL, 'value');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '2013-01-01', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '2013-01-01', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'GAAAA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'AAAAA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__ac9935', 711.020062);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '2013-01-01', 582.588439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'A[1I_', 572.766956);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'AI?#G', 206.939346);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.Consumption) / 12 FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME';

/*
Gold Result:
(14.312242166666666,)
*/

-- Prediction Query
SELECT AVG(Consumption) / 12 FROM yearmonth WHERE Date BETWEEN '201301' AND '201312' AND CustomerID IN (SELECT CustomerID FROM customers WHERE Segment = 'SME');

/*
Prediction Result:
(None,)
*/