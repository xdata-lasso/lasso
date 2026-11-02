-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default1', '2012'), (-1, '201201', '201212'), (0, '201212', '2012');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (0, 'default2', 0.0), (0, 'EUR', NULL), (-1, '2012', -1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(T1.Currency = 'CZK', T2.Consumption, 0)) - SUM(IIF(T1.Currency = 'EUR', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2012';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT (SELECT SUM("consumption") FROM "yearmonth" INNER JOIN "customers" ON "yearmonth"."customerid" = "customers"."customerid" WHERE "customers"."currency" = 'CZK' AND "yearmonth"."date" BETWEEN '201201' AND '201212') - (SELECT SUM("consumption") FROM "yearmonth" INNER JOIN "customers" ON "yearmonth"."customerid" = "customers"."customerid" WHERE "customers"."currency" = 'EUR' AND "yearmonth"."date" BETWEEN '201201' AND '201212') AS "difference_in_consumption";

/*
Prediction Result:
(None,)
*/