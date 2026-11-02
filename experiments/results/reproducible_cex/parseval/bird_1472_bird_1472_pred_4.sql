-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'LAM', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-1, 'LAM', 'n8c4pgu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (0, 'LAM', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'LAM', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'LAM', 'n8c4pgu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'LAM', '4h');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'LAM', 'a2ypuzhsrwbb');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'LAM', 'luhvdltti');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'LAM', 'nprmdposii');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'LAM', 'nw6klf');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '2012-01-01', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '2012-01-01', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'AAAAA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'GAAAA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'ym__d72288', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '2012-01-01', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '2012-01-01', 86.520366);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, '2012-01-01', 268.82475);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, '2012-01-01', 749.826493);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, '2012-01-01', 182.319045);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, '2012-01-01', 75.403642);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, '2012-01-01', 741.842896);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.date BETWEEN 201201 AND 201212 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.customerid FROM customers AS c INNER JOIN yearmonth AS ym ON c.customerid = ym.customerid WHERE c.segment = 'LAM' AND SUBSTRING(ym.date, 1, 4) = '2012' GROUP BY c.customerid ORDER BY SUM(ym.consumption) ASC, c.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(8,)
*/