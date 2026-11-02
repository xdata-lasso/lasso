-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'LAM', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'LAM', 'n8c4pgu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'LAM', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'LAM', 'n8c4pgu7v');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_1', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_2', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_3', 711.020062);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_4', 944.247544);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_5', 994.117864);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_6', 749.826493);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_7', 503.083789);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_8', 320.851235);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_9', 113.643485);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_10', 855.355181);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_11', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_12', 304.02808);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_13', 182.319045);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_14', 998.421621);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_15', 207.290264);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_16', 787.938887);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, 'date_17', 582.588439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_18', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'date_19', 86.520366);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Consumption > 46.73, 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN transactions_1k.Amount > 46.73 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) FROM customers INNER JOIN transactions_1k ON customers.CustomerID = transactions_1k.CustomerID WHERE customers.Segment = 'LAM';

/*
Prediction Result:
(None,)
*/