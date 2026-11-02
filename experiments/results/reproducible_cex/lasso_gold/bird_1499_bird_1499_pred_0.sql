-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1001, 'purpose', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1002, 'brother', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1003, 'ago', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1004, 'site', 'EUR');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'face', 1005.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'election', 1012.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'dog', 1019.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'chair', 1026.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) / 12 AS MonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY T1.CustomerID ORDER BY MonthlyConsumption DESC LIMIT 1;

/*
Gold Result:
(338.6666666666667,)
*/

-- Prediction Query
SELECT MAX(T2.Consumption / 12) AS MaxMonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR';

/*
Prediction Result:
(85.54166666666667,)
*/