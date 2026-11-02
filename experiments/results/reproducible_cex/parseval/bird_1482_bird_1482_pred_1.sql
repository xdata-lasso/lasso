-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'KAM', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'swwqcgsk', '9n8c4pgu7v');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_1', 582.588439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_2', 680.190136);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_3', 487.053947);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_4', 86.520366);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_5', 65.761562);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_6', 779.409124);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_7', 640.719621);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_8', 770.236508);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_9', 268.82475);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_10', 710.998147);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_11', 945.642658);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_12', 795.366812);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_13', 378.476082);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_14', 783.93201);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_15', 718.397869);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_16', 324.940703);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_17', 399.341724);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_18', 110.957699);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_19', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_20', 711.020062);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_21', 944.247544);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0))) AS REAL) * 100 / SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID;

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
SELECT "segment", MAX(percentage_increase) AS max_increase, MIN(percentage_increase) AS min_increase FROM (SELECT c."segment", ((SUM(CASE WHEN SUBSTRING(y."date", 1, 4) = '2013' THEN y."consumption" ELSE 0 END) - SUM(CASE WHEN SUBSTRING(y."date", 1, 4) = '2012' THEN y."consumption" ELSE 0 END)) / SUM(CASE WHEN SUBSTRING(y."date", 1, 4) = '2013' THEN y."consumption" ELSE 0 END)) * 100 AS percentage_increase FROM "customers" AS c JOIN "yearmonth" AS y ON c."customerid" = y."customerid" WHERE c."currency" = 'EUR' AND c."segment" IN ('SME', 'LAM', 'KAM') GROUP BY c."segment");

/*
Prediction Result:
('KAM', None, None)
*/