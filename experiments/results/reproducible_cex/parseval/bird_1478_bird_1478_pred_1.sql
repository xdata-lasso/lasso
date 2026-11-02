-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 't1__a5ad6b', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 't1__a5ad6b', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 't1__a5ad6b', '4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 't1__a5ad6b', 'gu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 't1__a5ad6b', 'e4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, '4', 'gu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'rwbbp6luhvd', 'tti');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'bnp', 'mdpos');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (11, 'ie5', 'nw6klf');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_1', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_2', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_3', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_4', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_5', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_6', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_7', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_8', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_9', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_10', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_11', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_12', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_13', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_14', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_15', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_16', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_17', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_18', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'date_19', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, 'date_20', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, 'date_21', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'date_22', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, 'date_23', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (11, 'date_24', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (12, 'date_25', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (13, 'date_26', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID GROUP BY T1.Segment ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('4',)
*/

-- Prediction Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE NOT T2.Consumption IS NULL GROUP BY T1.Segment ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Prediction Result:
('hria2ypuzhs',)
*/