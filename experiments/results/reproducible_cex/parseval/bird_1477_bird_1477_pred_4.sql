-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'n8c4pgu7v', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'e4', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, '9n8', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'u7', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'fe4hri', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'value', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '5k5swwqcgs', 'EUR');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__f7a874', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 't2__f7a874', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_2', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483647, 'I', 2.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, 'I', 3.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_c80bdd', 475.173408);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_5', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'date_6', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, 'date_7', 710.998147);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_8', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'date_9', 572.766956);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('date',)
*/

-- Prediction Query
SELECT T1.Date FROM yearmonth AS T1 JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' GROUP BY T1."Date" ORDER BY SUM(T1.Consumption) DESC, T1.Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('date_9',)
*/