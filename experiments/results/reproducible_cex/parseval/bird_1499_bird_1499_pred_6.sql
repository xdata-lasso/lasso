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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'n8c4pgu7v', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'e4', 'hria2ypuzhs');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_1', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_2', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_3', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_4', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_5', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_6', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_7', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_8', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_9', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_10', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_11', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_12', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_13', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_14', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_15', 711.020062);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_16', 944.247544);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_17', 994.117864);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_18', 749.826493);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_19', 503.083789);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_20', 320.851235);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_21', 113.643485);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_22', 855.355181);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_23', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_24', 304.02808);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_25', 182.319045);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_26', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_27', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_28', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_29', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_30', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_31', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_32', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_33', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_34', 998.421621);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_35', 207.290264);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_36', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_37', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_38', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_39', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) / 12 AS MonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY T1.CustomerID ORDER BY MonthlyConsumption DESC LIMIT 1;

/*
Gold Result:
(658.3233509999999,)
*/

-- Prediction Query
SELECT MAX(T2.Consumption / 12) AS MaxMonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR';

/*
Prediction Result:
(83.20180175,)
*/