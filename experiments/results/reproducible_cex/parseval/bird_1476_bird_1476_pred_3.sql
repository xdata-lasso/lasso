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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'wbbp6luhvdlt', 'ilbnp');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'dpos', 'ie5');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'w6kl', 'a9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '00t5c4ecigc', 'e376nium52');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '2012-01-01', 874.871895);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '2012-01-01', 182.319045);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'OAAAA', 998.421621);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__bfaa9d', 207.290264);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '2012-01-01', 874.871895);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, '2012-01-01', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, '2012-01-01', 787.938887);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, '2012-01-01', 327.753528);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, '2012-01-01', 877.276439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, '2012-01-01', 816.814398);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(T1.Currency = 'CZK', T2.Consumption, 0)) - SUM(IIF(T1.Currency = 'EUR', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2012';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN customers.Currency = 'CZK' THEN yearmonth.Consumption ELSE 0 END) - SUM(CASE WHEN customers.Currency = 'EUR' THEN yearmonth.Consumption ELSE 0 END) AS CurrencyDifference FROM customers JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID WHERE yearmonth.Date BETWEEN '201201' AND '201212';

/*
Prediction Result:
(None,)
*/