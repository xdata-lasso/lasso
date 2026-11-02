-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'KAM', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'KAM', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '4', 'gu7v');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__15e11b', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '2012-01-01', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__b00021', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 't2__15e11b', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '2012-01-01', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 't2__b00021', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT CustomerID) FROM yearmonth WHERE Date BETWEEN '201201' AND '201212' AND Consumption < 30000 AND CustomerID IN (SELECT CustomerID FROM customers WHERE Segment = 'KAM');

/*
Prediction Result:
(0,)
*/