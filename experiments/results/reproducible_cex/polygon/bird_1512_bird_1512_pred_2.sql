-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (32, '33', '34');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, '32', '32');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 32, '32', '32');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 32, '32', '32');
INSERT INTO "products" ("productid", "description") VALUES (16, '32');
INSERT INTO "products" ("productid", "description") VALUES (15, '32');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (25, '2012-08-25', '26', 32, 27, 28, NULL, 30, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (17, '2012-08-25', '18', NULL, 20, 21, 22, 23, 24);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (32, '32', 32);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-25' GROUP BY CustomerID ORDER BY SUM(Price) DESC, CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT customers.CustomerID FROM transactions_1k INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k."Date" = '2012-08-25' GROUP BY customers.CustomerID ORDER BY SUM(transactions_1k.Amount) DESC, customers.CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
(32,)
*/