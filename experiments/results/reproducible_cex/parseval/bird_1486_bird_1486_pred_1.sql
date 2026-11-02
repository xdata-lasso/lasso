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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '4', 'gu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'rwbbp6luhvd', 'tti');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'bnp', 'mdpos');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'ie5', 'nw6klf');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '2eutliqa11r', 'ytoo3o9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'l7', 'klex14ji');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (11, '7zwau2dwyr', '13pyu');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, '8d99rljsl', 'b4yp5qi');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, '1vy9uxj4', 'wb');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, 'v', 'ph2');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, 'nd', 'wnqcx');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (17, '5hncprjtu0d', '79fjgq8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, 'kn6vc', '6ah');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST((SELECT COUNT(DISTINCT CustomerID) FROM customers WHERE Segment = 'SME' AND Currency = 'CZK') AS REAL) - CAST((SELECT COUNT(DISTINCT CustomerID) FROM customers WHERE Segment = 'SME' AND Currency = 'EUR') AS REAL) AS more_smes;

/*
Prediction Result:
(0.0,)
*/