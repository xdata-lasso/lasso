-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 't2__6e0046');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '9n8', 't2__6e0046');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, '4', 't2__6e0046');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'gu7v', 't2__6e0046');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, '4', 'gu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'value', NULL);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201306', 214582.17);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '201306', 214582.17);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't1__953739', 214582.17);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 86.520366);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '201306', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, '201306', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 't1__c3a94f', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, '201306', 214582.17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Currency FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201306' AND T1.Consumption = 214582.17;

/*
Gold Result:
('t2__6e0046',)
('t2__6e0046',)
('9n8',)
*/

-- Prediction Query
SELECT DISTINCT customers.currency FROM customers INNER JOIN yearmonth ON customers.customerid = yearmonth.customerid WHERE SUBSTRING(yearmonth.date, 1, 6) = '201306' AND yearmonth.consumption = 214582.17;

/*
Prediction Result:
('t2__6e0046',)
('9n8',)
*/