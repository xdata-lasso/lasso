-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'KAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2437, 'KAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (0, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-1, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483644, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2438, 'SME', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483641, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2439, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483639, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483638, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483637, 'KAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483636, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483635, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483634, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483633, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483632, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483631, 'KAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483630, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483629, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483628, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483627, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483626, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483625, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483624, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483623, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483622, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483621, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483620, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483619, 'LAM', 'CZK');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'hsrwbbp', 'luhvdltti');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'bnp', 'mdpos');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'ie5', 'nw6klf');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_c80bdd', 582.588439);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '2013', 680.190136);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__830eba', 487.053947);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__180d8d', 486.033807);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__a8a025', 345.329712);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'g', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2437, '%', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2437, 'c', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 't2__830eba', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 't2__a4d6bc', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__a70484', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__7f9616', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 't2__a8a025', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 't2__771ba6', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2438, '2013', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2438, 'a', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'A', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'B', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, 't2__830eba', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, 't2__a4d6bc', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, 't2__a8a025', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, 't2__771ba6', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, ')', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'D', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'a', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2437, 't2__180d8d', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2437, '2013', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'C', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, '@', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, 'S', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'A', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '"', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '#', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2438, 't2__a70484', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2438, 't2__7f9616', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '$', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '!', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'm', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2438, 't2__830eba', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2438, 't2__a4d6bc', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '@', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2438, 'A', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '&', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'K', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'I', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, '"', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, 'A', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2437, 't2__a8a025', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2437, 't2__771ba6', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2437, '(', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2437, '|', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '#', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, '!', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, 'B', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__5fcc79', 833.684115);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__c7782b', 261.897639);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__930b0e', 97.952323);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__771ba6', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__a4d6bc', 557.512061);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '$', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'c', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'l', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'E', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'H', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'I', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'b', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, '#', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'O', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '*', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'B', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, 'P', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'a', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '(', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, ')', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2439, 'date_41', 673.065986);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483625, 'date_42', 825.231787);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483619, 'date_43', 75.551482);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483633, 'date_44', 297.722676);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483622, 'date_45', 138.017996);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-2147483637, 'date_46', 251.267403);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
SELECT (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) - (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) AS diff1, (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) - (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) AS diff2, (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) - (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) AS diff3;

/*
Prediction Result:
(None, None, 341.095068)
*/