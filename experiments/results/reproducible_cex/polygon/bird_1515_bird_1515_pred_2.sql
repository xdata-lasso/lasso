-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (24, '38', '22');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (32, '38', '30');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 38, '38', '38');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 38, '38', '38');
INSERT INTO "products" ("productid", "description") VALUES (17, '38');
INSERT INTO "products" ("productid", "description") VALUES (16, '38');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (23, '2012-08-23', '76800', 24, 25, 26, 27, 28, 29);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (31, '2012-08-23', '76800', 32, 33, 34, 35, 36, 37);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (32, '38', 38);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.date = '2012-08-23' AND T1.time = '21:20:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT customers.segment FROM customers INNER JOIN transactions_1k ON customers.customerid = transactions_1k.customerid WHERE transactions_1k.date = '2012-08-23' AND transactions_1k.time = '21:20:00';

/*
Prediction Result:
*/