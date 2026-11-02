-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'KAM', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'KAM', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'KAM', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'cus_999f0e', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (11, 'KAM', 'EUR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(Currency = 'EUR') AS REAL) * 100 / COUNT(CustomerID) FROM customers WHERE Segment = 'KAM';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN Currency = 'EUR' THEN 1 ELSE 0 END) AS REAL) / COUNT(*)) * 100 AS percentage_of_KAM_uses_Euro FROM customers WHERE Segment = 'KAM';

/*
Prediction Result:
(66.66666666666666,)
*/