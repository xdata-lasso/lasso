-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 't2__3589e1');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, '9n8', 't2__3589e1');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '4', 't2__3589e1');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'gu7v', 'e4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'hria2ypuzhs', 't2__6633df');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'rwbbp6luhvd', 't2__6633df');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, '4', 'gu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'e4', 'hria2ypuzhs');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201306', 214582.17);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '201306', 214582.17);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't1__e07472', 214582.17);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 779.409124);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, '201306', 214582.17);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '201306', 214582.17);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, '201306', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, '201306', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, 't1__b68f0b', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Currency FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201306' AND T1.Consumption = 214582.17;

/*
Gold Result:
('t2__3589e1',)
('e4',)
('t2__6633df',)
('t2__6633df',)
*/

-- Prediction Query
SELECT c.Currency FROM yearmonth AS y JOIN customers AS c ON y.CustomerID = c.CustomerID WHERE y."Date" LIKE '201306%' GROUP BY y.CustomerID HAVING SUM(y.Consumption) > 214582.17;

/*
Prediction Result:
*/