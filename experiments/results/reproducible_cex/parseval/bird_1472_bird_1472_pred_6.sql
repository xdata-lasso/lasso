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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-1, 'LAM', 'n8c4pgu7v');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'e4', 'hria2ypuzhs');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201201', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '201201', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (4, '201202', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201202', 663.049759);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__c0830b', 711.020062);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.date BETWEEN 201201 AND 201212 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT c.CustomerID FROM customers AS c JOIN yearmonth AS y ON c.CustomerID = y.CustomerID WHERE c.Segment = 'LAM' AND y.Date LIKE '2012%' ORDER BY y.Consumption ASC, c.customerid NULLS LAST, y.date NULLS LAST, y.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/