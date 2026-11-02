-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (29, 'CZK27', 'CZK');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, 'CZK29', 'CZK29');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, 29, 'CZK29', 'CZK29');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 29, 'CZK29', 'CZK29');
INSERT INTO "products" ("productid", "description") VALUES (19, 'CZK29');
INSERT INTO "products" ("productid", "description") VALUES (18, 'CZK29');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '1000-01-30', 'CZK29', 29, 29, 29, 29, 29, 29);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-01-30', 'CZK29', 29, 29, 29, 29, 29, 29);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (29, 'CZK201102', 26);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (29, 'CZK201101', 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Date BETWEEN 201101 AND 201112 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.CustomerID FROM customers AS c JOIN yearmonth AS ym ON c.CustomerID = ym.CustomerID WHERE c.Currency = 'CZK' AND ym.Date BETWEEN 201101 AND 201112 ORDER BY ym.Consumption DESC, c.customerid NULLS LAST, ym.date NULLS LAST, ym.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/