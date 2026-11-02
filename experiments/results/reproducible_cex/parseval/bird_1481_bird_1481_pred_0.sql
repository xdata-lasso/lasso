-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '5k5swwqcgs', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '9n8', '4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'u7', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483645, 'puzhsrw', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'b', 'p6luhvdlttil');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483643, 'prmd', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'posiie5unw6k', 'fa9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483641, '0t5c4ecigc', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'e376nium52', 'zbuo4nrqrof');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '201301', 249.706432);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201301', 328.996339);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201302', 906.21648);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_3', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_4', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_5', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_6', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__481bc6', 134.487977);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, 'date_8', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_9', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '201306', 998.421621);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '@', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'A', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483645, '201306', 627.258639);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'G', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483645, 'A', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '201306', 389.878901);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (6, '@', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (5, 'A', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
WITH MinConsumption AS (SELECT c.Segment, y.CustomerID, SUM(y.Consumption) AS TotalConsumption FROM yearmonth AS y JOIN customers AS c ON y.CustomerID = c.CustomerID WHERE c.Currency = 'CZK' AND y.Date BETWEEN '201301' AND '201312' GROUP BY c.Segment, y.CustomerID), LeastConsumption AS (SELECT Segment, MIN(TotalConsumption) AS MinTotalConsumption FROM MinConsumption GROUP BY Segment), AvgConsumption AS (SELECT mc.Segment, AVG(mc.TotalConsumption) AS AvgConsumption FROM MinConsumption AS mc JOIN LeastConsumption AS lc ON mc.Segment = lc.Segment AND mc.TotalConsumption = lc.MinTotalConsumption GROUP BY mc.Segment) SELECT c1.Segment AS Segment1, c2.Segment AS Segment2, CAST(c1.AvgConsumption AS REAL) - CAST(c2.AvgConsumption AS REAL) AS Difference FROM AvgConsumption AS c1 JOIN AvgConsumption AS c2 ON (c1.Segment = 'SME' AND c2.Segment = 'LAM') OR (c1.Segment = 'LAM' AND c2.Segment = 'KAM') OR (c1.Segment = 'KAM' AND c2.Segment = 'SME');

/*
Prediction Result:
*/