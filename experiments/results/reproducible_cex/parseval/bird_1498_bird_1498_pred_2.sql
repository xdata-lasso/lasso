-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483648, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'gu7v', 'e4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483646, 'ia2yp', 'uzhsrwbbp6lu');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483645, 'tilbn', 'rmdp');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483644, 'siie5unw6k', 'fa9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483643, '0t5c4ecigc', 'e376nium52');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483642, 'buo4nrq', 'rofqyp5s5b');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483641, '02eu', 'liqa1');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483640, 'yytoo', 'o9hl72kl');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483648, '2012-01-01', 874.871895);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483647, '2012-01-01', 779.409124);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483646, '2012-01-01', 737.440743);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483647, 'AAAAA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483648, 'AAAAA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483645, 'AAAAA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483644, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483645, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483643, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483642, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483641, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483640, '2012-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Consumption) FROM yearmonth WHERE SUBSTRING(Date, 1, 4) = '2012' GROUP BY SUBSTRING(Date, 5, 2) ORDER BY SUM(Consumption) DESC LIMIT 1;

/*
Gold Result:
(2391.721762,)
*/

-- Prediction Query
SELECT Consumption FROM yearmonth WHERE SUBSTRING(Date, 1, 4) = '2012' ORDER BY Consumption DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(874.871895,)
*/