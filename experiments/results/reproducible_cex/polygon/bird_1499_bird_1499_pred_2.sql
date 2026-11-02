-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (30, 'EUR31', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (34, NULL, 'EUR');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, 30, 'EUR30', 'EUR30');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 30, 'EUR30', 'EUR30');
INSERT INTO "products" ("productid", "description") VALUES (19, 'EUR30');
INSERT INTO "products" ("productid", "description") VALUES (18, 'EUR30');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '1000-01-31', 'EUR30', 30, 30, 30, 30, 30, 30);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-01-31', 'EUR30', 30, 30, 30, 30, 30, 30);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (30, 'EUR28', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (34, 'EUR32', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) / 12 AS MonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY T1.CustomerID ORDER BY MonthlyConsumption DESC LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT MAX(monthly_consumption) AS max_monthly_consumption FROM (SELECT SUM(Consumption) / 12 AS monthly_consumption FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' GROUP BY T1.CustomerID);

/*
Prediction Result:
(None,)
*/