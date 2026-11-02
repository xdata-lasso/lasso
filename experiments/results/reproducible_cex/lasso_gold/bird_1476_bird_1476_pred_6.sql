-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1001, 'purpose', 'CZK');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1002, 'brother', 'EUR');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, '2012', 1003.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, 'ago', 1010.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(T1.Currency = 'CZK', T2.Consumption, 0)) - SUM(IIF(T1.Currency = 'EUR', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2012';

/*
Gold Result:
(1003.5,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN customers.Currency = 'CZK' THEN yearmonth.Consumption ELSE 0 END) - SUM(CASE WHEN customers.Currency = 'EUR' THEN yearmonth.Consumption ELSE 0 END) AS CurrencyDifference FROM customers JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID WHERE yearmonth.Date BETWEEN '201201' AND '201212';

/*
Prediction Result:
(None,)
*/