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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'rwbbp6luhvd', 'tti');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'wbbp6luhvdlt', 'ilbnp');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'dpos', 'ie5');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'w6kl', 'a9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '00t5c4ecigc', 'e376nium52');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'buo4nrq', 'rofqyp5s5b');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__4a6980', 874.871895);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 't2__4a6980', 182.319045);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__6505b1', 998.421621);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, 'date_3', 874.871895);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'date_4', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, 'date_5', 787.938887);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (7, 'date_6', 327.753528);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (8, 'date_7', 877.276439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (9, 'date_8', 816.814398);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, 'date_9', 22.720462);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0))) AS REAL) * 100 / SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID;

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
SELECT T1.Segment, MAX(T2.PercentageIncrease) AS MaxPercentageIncrease, MIN(T2.PercentageIncrease) AS MinPercentageIncrease FROM customers AS T1 INNER JOIN (SELECT T3.Segment, (SUM(IIF(SUBSTRING(T4.Date, 1, 4) = '2013', T4.Consumption, 0)) - SUM(IIF(SUBSTRING(T4.Date, 1, 4) = '2012', T4.Consumption, 0))) * 100 / SUM(IIF(SUBSTRING(T4.Date, 1, 4) = '2013', T4.Consumption, 0)) AS PercentageIncrease FROM customers AS T3 INNER JOIN yearmonth AS T4 ON T3.CustomerID = T4.CustomerID WHERE T3.Currency = 'EUR' GROUP BY T3.Segment) AS T2 ON T1.Segment = T2.Segment GROUP BY T1.Segment;

/*
Prediction Result:
*/