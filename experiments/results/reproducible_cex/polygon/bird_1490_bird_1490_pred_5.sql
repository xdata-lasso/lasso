-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (28, 'LAM', 'LAM27');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, 'LAM31', NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, 28, 'LAM28', 'LAM28');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 28, 'LAM28', 'LAM28');
INSERT INTO "products" ("productid", "description") VALUES (19, 'LAM28');
INSERT INTO "products" ("productid", "description") VALUES (18, 'LAM28');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '1000-01-29', 'LAM28', 28, 28, 28, 28, 28, 28);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-01-29', 'LAM28', 28, 28, 28, 28, 28, 28);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (28, 'LAM29', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (15, 'LAM22', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Consumption > 46.73, 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.Consumption > 46.73 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Segment = 'LAM';

/*
Prediction Result:
(0.0,)
*/