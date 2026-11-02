-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'rwbbp6luhvd', 'tti');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, '4', 'gu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'rwbbp6luhvd', 'tti');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'bnp', 'mdpos');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'ie5', 'nw6klf');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (11, 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, '2eutliqa11r', 'ytoo3o9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'l7', 'klex14ji');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, '7zwau2dwyr', '13pyu');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, '8d99rljsl', 'b4yp5qi');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (17, '1vy9uxj4', 'wb');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, 'v', 'ph2');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, 'nd', 'wnqcx');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201309', 874.871895);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '201309', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__9f506a', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__2c69e5', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 182.319045);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (13, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (12, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (15, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (14, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (11, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (16, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (17, '201309', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (18, '201309', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT y.CustomerID FROM yearmonth AS y INNER JOIN transactions_1k AS t ON y.CustomerID = t.CustomerID WHERE y."Date" LIKE '201309%' GROUP BY y.CustomerID ORDER BY SUM(t.Amount) DESC, y.CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
*/