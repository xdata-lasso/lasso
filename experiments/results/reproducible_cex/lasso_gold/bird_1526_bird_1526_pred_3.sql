-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (0, 'require', 'wait');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1016, 'sit', 'offer');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1017, 1019, 'Benin', 'knowledge');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1018, 1024.0, 'Nauru', 'almost');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1021, '2012-08-25', 'all', 0, 1023, 1017, 1025, 1027, 634.8);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1022, '2012-08-25', 'better', 1016, 1034.0, 1018, 1040.0, 1044.0, 634.8);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '2012', 1031.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'discover', 1034.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT ((SELECT T2.Consumption FROM yearmonth AS T2 WHERE T2.CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8) AND T2.Date LIKE '2012%') - (SELECT T3.Consumption FROM yearmonth AS T3 WHERE T3.CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8) AND T3.Date LIKE '2013%')) / (SELECT T2.Consumption FROM yearmonth AS T2 WHERE T2.CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8) AND T2.Date LIKE '2012%') AS ConsumptionDecreaseRate;

/*
Prediction Result:
(None,)
*/