-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'n8c4pgu7v', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'SME', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'KAM', 'CZK');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '2013-01-01', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '2013-01-01', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'AAAAA', 711.020062);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__f5415d', 944.247544);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '2013-01-01', 582.588439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, '2013-01-01', 680.190136);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, '2013-01-01', 487.053947);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
SELECT SUM(CASE WHEN T1.Segment = 'SME' THEN T2.Consumption ELSE 0 END) / COUNT(CASE WHEN T1.Segment = 'SME' THEN T1.CustomerID ELSE NULL END) - SUM(CASE WHEN T1.Segment = 'LAM' THEN T2.Consumption ELSE 0 END) / COUNT(CASE WHEN T1.Segment = 'LAM' THEN T1.CustomerID ELSE NULL END), SUM(CASE WHEN T1.Segment = 'LAM' THEN T2.Consumption ELSE 0 END) / COUNT(CASE WHEN T1.Segment = 'LAM' THEN T1.CustomerID ELSE NULL END) - SUM(CASE WHEN T1.Segment = 'KAM' THEN T2.Consumption ELSE 0 END) / COUNT(CASE WHEN T1.Segment = 'KAM' THEN T1.CustomerID ELSE NULL END), SUM(CASE WHEN T1.Segment = 'KAM' THEN T2.Consumption ELSE 0 END) / COUNT(CASE WHEN T1.Segment = 'KAM' THEN T1.CustomerID ELSE NULL END) - SUM(CASE WHEN T1.Segment = 'SME' THEN T2.Consumption ELSE 0 END) / COUNT(CASE WHEN T1.Segment = 'SME' THEN T1.CustomerID ELSE NULL END) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND SUBSTRING(T2.Date, 1, 4) = '2013';

/*
Prediction Result:
(-97.60169700000006, 193.13618900000006, -95.534492)
*/