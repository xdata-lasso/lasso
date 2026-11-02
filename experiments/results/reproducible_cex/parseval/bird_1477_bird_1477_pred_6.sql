-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'n8c4pgu7v', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'e4', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '9n8', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'u7', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'fe4hri', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'value', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, '8c4p', 'EUR');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__692246', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '!', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '`', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'a', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_5', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_6', 304.02808);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'O', 2.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'O', 3.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_c80bdd', 475.173408);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'date_9', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'date_10', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, 'date_11', 710.998147);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'date_12', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, 'date_13', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, 'date_14', 935.695299);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_15', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('date',)
*/

-- Prediction Query
SELECT SUBSTRING(T1.Date, 1, 4) AS Year, SUM(T1.Consumption) AS TotalConsumption FROM yearmonth AS T1 JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' GROUP BY SUBSTRING(T1.Date, 1, 4) ORDER BY TotalConsumption DESC, Year NULLS LAST LIMIT 1;

/*
Prediction Result:
('date', 1592.849169)
*/