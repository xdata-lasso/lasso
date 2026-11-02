-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, '30', NULL);
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, NULL, '43');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (21, 19, '19', '19');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (20, 19, '19', '19');
INSERT INTO "products" ("productid", "description") VALUES (23, '19');
INSERT INTO "products" ("productid", "description") VALUES (22, '19');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (25, '1000-02-02', NULL, 18, 34, 35, 36, NULL, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (24, NULL, NULL, 19, NULL, NULL, NULL, 0, -865);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (19, '19', 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Price / T2.Amount), T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.CustomerID = (SELECT CustomerID FROM yearmonth ORDER BY Consumption DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1) GROUP BY T2.CustomerID, T1.Currency;

/*
Gold Result:
(19, None, None)
*/

-- Prediction Query
SELECT t1.CustomerID, AVG(t1.Price / t1.Amount) AS average_price, t2.Currency FROM transactions_1k AS t1 JOIN customers AS t2 ON t1.CustomerID = t2.CustomerID GROUP BY t1.CustomerID ORDER BY SUM(t1.Price) DESC, t1.CustomerID NULLS LAST, average_price NULLS LAST, t2.Currency NULLS LAST LIMIT 1;

/*
Prediction Result:
(19, None, None)
*/