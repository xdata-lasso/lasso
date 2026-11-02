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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '9n8', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '4', 'gu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, '9n8', 't2__17518a');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, '4', 't2__17518a');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_1', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_2', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_3', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_4', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_5', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_6', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_7', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_8', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_9', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_10', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_11', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_12', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_13', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_14', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_15', 1000.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_16', 86.520366);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_17', 1000.01);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, 'date_18', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_19', 1000.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'date_20', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' AND T1.Consumption > 1000.00;

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT y.CustomerID) FROM yearmonth AS y JOIN customers AS c ON y.CustomerID = c.CustomerID WHERE c.Currency = 'EUR' AND y.Consumption > 1000;

/*
Prediction Result:
(1,)
*/