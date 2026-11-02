-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'SME', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'SME', 'n8c4pgu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'SME', 'e4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'SME', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 't1__4b38df', '8c4pgu7vfe');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, NULL, 'value');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '2013-01-01', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '!', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '#', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '''', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'A', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'AAAAA', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_7', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_8', 304.02808);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483647, '2013-01-01', 572.766956);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '2013-01-01', 206.939346);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '2013-01-01', 483.665643);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, '2013-01-01', 818.685402);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, 'AK3G?', 804.971537);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 5, 2) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME' GROUP BY SUBSTRING(T2.Date, 5, 2) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 5, 2) NULLS LAST LIMIT 1;

/*
Gold Result:
('-0',)
*/

-- Prediction Query
SELECT SUBSTRING(Date, 6, 2) AS Month, SUM(Consumption) AS Total_Consumption FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Segment = 'SME' AND SUBSTRING(T1.Date, 1, 4) = '2013' GROUP BY Month ORDER BY Total_Consumption DESC, Month NULLS LAST LIMIT 1;

/*
Prediction Result:
('01', 951.453208)
*/