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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '9n8', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'u7', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'fe4hri', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'value', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '5k5swwqcgs', 'EUR');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__199c75', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '4', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '!', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_4', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_c80bdd', 475.173408);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'O', 2.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, 'O', 3.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, 'date_7', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'date_8', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, 'date_9', 710.998147);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_10', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'date_11', 572.766956);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('date',)
*/

-- Prediction Query
SELECT STRFTIME('%Y', T1.Date) FROM "transactions_1k" AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' GROUP BY STRFTIME('%Y', T1.Date) ORDER BY SUM(T1.Amount) DESC, STRFTIME('%Y', T1.Date) NULLS LAST LIMIT 1;

/*
Prediction Result:
*/