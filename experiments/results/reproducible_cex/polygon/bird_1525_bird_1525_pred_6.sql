-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (38, 'EUR39', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'EUR38', 'EUR38');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 38, 'EUR38', 'EUR38');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 38, 'EUR38', 'EUR38');
INSERT INTO "products" ("productid", "description") VALUES (17, 'EUR38');
INSERT INTO "products" ("productid", "description") VALUES (16, 'EUR38');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (24, '2012-08-25', 'EUR25', 38, 26, 27, 28, 29, 30);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (31, '2012-08-25', 'EUR32', 38, 33, 34, 35, 36, 37);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (38, 'EUR19', 38);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (38, 'EUR18', 38);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN customers.Currency = 'EUR' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(DISTINCT transactions_1k.CustomerID) AS EUR_Percentage FROM transactions_1k INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.Date = '2012-08-25';

/*
Prediction Result:
(200.0,)
*/