-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 't1__505a84', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 't1__505a84', 'n8c4pgu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 't1__505a84', 'e4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'wbbp6luhvdlt', 'ilbnp');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'dpos', 'ie5');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'w6kl', 'a9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '00t5c4ecigc', 'e376nium52');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'buo4nrq', 'rofqyp5s5b');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (11, '02eu', 'liqa1');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, 'yytoo', 'o9hl72kl');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201309', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '201309', 779.409124);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, '201309', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__306031', 304.02808);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 182.319045);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '201309', 874.871895);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '201309', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, '201309', 787.938887);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, '201309', 327.753528);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, '201309', 877.276439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, '201309', 816.814398);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, '201309', 22.720462);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (11, '201309', 982.938576);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (12, '201309', 74.250383);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('buo4nrq',)
*/

-- Prediction Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.Segment ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Prediction Result:
('buo4nrq',)
*/