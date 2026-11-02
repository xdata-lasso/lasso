-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '5k5swwqcgsk', '9n8c4pgu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (11, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (17, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, 'LAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, 'LAM', 'EUR');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201310', 582.588439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '201310', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__ee5677', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__1506eb', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 86.520366);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (13, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (12, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (15, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (14, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (17, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (16, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (19, '201310', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (18, '201310', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.Date = '201310' AND T1.Currency = 'EUR' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T1.Currency = 'Euro' AND T2.Date = '201310' ORDER BY T2.Consumption DESC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/