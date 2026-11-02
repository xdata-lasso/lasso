-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483648, 'SME', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'SME', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483646, 'SME', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483645, 'SME', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483644, 'cus_447f49', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483643, 'SME', '4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483642, 'SME', 'cus_675a42');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483641, 'SME', 'cus_675a42');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483640, 'SME', 'cus_675a42');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'SME', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'SME', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'SME', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'SME', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'SME', 'CZK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN T1.Currency = 'CZK' THEN T2.Amount ELSE 0 END) - SUM(CASE WHEN T1.Currency = 'EUR' THEN T2.Amount ELSE 0 END) AS Difference FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME';

/*
Prediction Result:
(None,)
*/