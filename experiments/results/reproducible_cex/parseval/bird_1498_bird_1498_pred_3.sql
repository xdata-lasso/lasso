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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483645, 'l', 'tilbn');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483644, 'mdpos', 'ie5');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483643, 'w6kl', 'a9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483642, '0t5c4ec', 'gce');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483641, '6nium52zb', 'uo4nrqrofqy');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483640, 's5bbp02e', 'tliqa1');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483639, 'ytoo3o9', 'l7');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483638, 'lex', '4ji7zwa');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483637, '2dwyrq13pyu7', 'd99rljsl0');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483636, 'i2rkf', 'vqx58pz0f');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483635, '8jegd21vy9ux', 'j4hwbdvlph');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483634, 'nd', 'wnqcx');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483633, 'hncprjtu', 'dz79fjg');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483632, 'n2f3dqv0g', 'cb98ozk3zbil');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483631, 'kn6vc', '6ah');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483648, '2012-01-01', 874.871895);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483647, '2012-01-01', 779.409124);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483646, '2012-01-01', 737.440743);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483645, '2012-01-01', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483644, '2012-01-01', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483643, '2012-01-01', 877.276439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483642, '2012-01-01', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483641, '2012-01-01', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483640, '2012-01-01', 982.938576);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483639, '2012-01-01', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483638, '2012-01-01', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483637, '2012-01-01', 27.036693);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483642, '?A!AA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483639, '?A!AA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483645, '?A!AA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483636, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483635, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483634, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483633, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483632, '2012-01-01', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483631, '2012-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Consumption) FROM yearmonth WHERE SUBSTRING(Date, 1, 4) = '2012' GROUP BY SUBSTRING(Date, 5, 2) ORDER BY SUM(Consumption) DESC LIMIT 1;

/*
Gold Result:
(4280.473470000001,)
*/

-- Prediction Query
SELECT MAX(Consumption) FROM yearmonth WHERE SUBSTRING("Date", 1, 4) = '2012';

/*
Prediction Result:
(982.938576,)
*/