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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'n8c4pgu7v', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '9n8', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'value', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, '9n8', '4');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_1', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_2', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_3', 711.020062);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_4', 944.247544);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_5', 994.117864);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_6', 749.826493);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_7', 503.083789);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_8', 320.851235);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_9', 113.643485);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_10', 855.355181);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_11', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_12', 304.02808);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_13', 182.319045);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_14', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_15', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_16', 998.421621);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_17', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_18', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_19', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_20', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_21', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_22', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'date_23', 874.871895);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, 'date_24', 249.706432);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) / 12 AS MonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY T1.CustomerID ORDER BY MonthlyConsumption DESC LIMIT 1;

/*
Gold Result:
(364.88789325,)
*/

-- Prediction Query
SELECT SUM(T2.Consumption) / 12 AS MonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'euro' GROUP BY T2.Date ORDER BY MonthlyConsumption DESC LIMIT 1;

/*
Prediction Result:
*/