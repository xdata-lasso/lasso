-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, 'LAM27', NULL);
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'LAM', 'LAM30');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 13, 'LAM13', 'LAM13');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 13, 'LAM13', 'LAM13');
INSERT INTO "products" ("productid", "description") VALUES (18, 'LAM13');
INSERT INTO "products" ("productid", "description") VALUES (17, 'LAM13');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-01-14', 'LAM13', 13, 13, 13, 13, 13, 13);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '1000-01-14', 'LAM13', 13, 13, 13, 13, 13, 13);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (13, 'LAM22', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (14, 'LAM21', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Consumption > 46.73, 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (CAST(COUNT(CASE WHEN Consumption > 46.73 THEN 1 END) AS REAL) * 100.0 / CAST(COUNT(*) AS REAL)) AS percentage FROM yearmonth JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE Segment = 'LAM';

/*
Prediction Result:
(0.0,)
*/