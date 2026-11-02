-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (39, '30', '31');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, '39', '39');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 39, '39', '39');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 39, '39', '39');
INSERT INTO "products" ("productid", "description") VALUES (16, '39');
INSERT INTO "products" ("productid", "description") VALUES (15, '39');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (23, '2012-08-25', '24', 39, 25, 26, 27, 28, 29);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (32, '2012-08-25', '33', 39, 34, 35, 36, 37, 38);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (12, '18', 39);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (12, '17', 39);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-25' GROUP BY CustomerID ORDER BY SUM(Price) DESC, CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(39,)
*/

-- Prediction Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2."Date" = '2012-08-25' ORDER BY T2.Amount DESC, T1.customerid NULLS LAST, T2.transactionid NULLS LAST LIMIT 1;

/*
Prediction Result:
(39,)
*/