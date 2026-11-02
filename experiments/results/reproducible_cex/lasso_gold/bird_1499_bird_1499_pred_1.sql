-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1049, 'EUR', 'best');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1050, 'EUR', 'best');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1051, 'EUR', 'best');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1052, 'EUR', 'best');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1049, 'husband', 1053.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1049, 'bill', 1060.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1049, 'her', 1067.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1049, 'throw', 1074.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) / 12 AS MonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY T1.CustomerID ORDER BY MonthlyConsumption DESC LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(total_consumption / 12) AS biggest_monthly_consumption FROM (SELECT SUM(yearmonth.consumption) AS total_consumption FROM yearmonth INNER JOIN customers ON yearmonth.customerid = customers.customerid WHERE customers.currency = 'EUR' GROUP BY yearmonth.customerid);

/*
Prediction Result:
(None,)
*/