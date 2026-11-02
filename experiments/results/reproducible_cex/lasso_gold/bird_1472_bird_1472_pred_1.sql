-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1107, 'LAM', 'long');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1108, 'LAM', 'prove');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1109, 'LAM', 'they');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1110, 'LAM', 'his');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1107, 201200, 1111.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1107, 'commercial', 1118.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1107, 'hospital', 1125.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1107, 'hear', 1132.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.date BETWEEN 201201 AND 201212 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2012' AND T1.Segment = 'LAM' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
(1107,)
*/