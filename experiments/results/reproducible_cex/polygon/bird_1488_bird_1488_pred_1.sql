-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, 'KAM27', 'KAM33');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (33, 'KAM', 'KAM28');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 33, 'KAM33', 'KAM33');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 33, 'KAM33', 'KAM33');
INSERT INTO "products" ("productid", "description") VALUES (18, 'KAM33');
INSERT INTO "products" ("productid", "description") VALUES (17, 'KAM33');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-02-03', 'KAM33', 33, 33, 33, 33, 33, 33);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '1000-02-03', 'KAM33', 33, 33, 33, 33, 33, 33);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (33, 'KAM22', -229);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (33, 'KAM21', -228);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' GROUP BY T2.CustomerID ORDER BY SUM(T2.Consumption) DESC, T2.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(33, -457.0)
*/

-- Prediction Query
SELECT CustomerID, MAX(Consumption) AS MaxConsumption FROM yearmonth WHERE CustomerID IN (SELECT CustomerID FROM customers WHERE Segment = 'KAM') GROUP BY CustomerID ORDER BY MaxConsumption DESC, CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
(33, -228.0)
*/