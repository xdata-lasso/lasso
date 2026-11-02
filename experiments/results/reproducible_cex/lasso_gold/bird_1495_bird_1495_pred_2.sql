-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1018, 'mouth', 'decide');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1019, 'play', 'sense');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1020, 'agreement', 'rate');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1021, 'option', 'science');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1026, 'mouth', 'decide');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1018, '201309', 1022.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1018, 'offer', 1029.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1018, 'kind', 1036.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1018, 'discussion', 1043.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1026, '201309', 1022.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1018,)
*/

-- Prediction Query
SELECT yearmonth.customerid FROM yearmonth INNER JOIN (SELECT MAX(consumption) AS max_consumption FROM yearmonth WHERE date = '201309') AS max_values ON yearmonth.consumption = max_values.max_consumption AND yearmonth.date = '201309';

/*
Prediction Result:
(1018,)
(1026,)
*/