-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (0, 'purpose', 'ago');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1001, 'brother', 'site');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1002, 1004, 'Falkland Islands (Malvinas)', 'dog');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1003, 1009.0, 'Ecuador', 'chair');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1006, '2012-08-25', 'since', 0, 1008, 1002, 1010, 1012, 634.8);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1007, '2012-08-25', 'blue', 1001, 1019.0, 1003, 1025.0, 1029.0, 634.8);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '2012', 1014.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '2013', 1021.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(-0.006899950714637753,)
*/

-- Prediction Query
SELECT (T1.Consumption - (SELECT Consumption FROM yearmonth WHERE CustomerID = T1.CustomerID AND "Date" LIKE '201308')) / T1.Consumption FROM yearmonth AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Amount = 634.8 AND T2."Date" LIKE '2012-08-25';

/*
Prediction Result:
*/