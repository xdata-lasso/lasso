-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, 'EUR18', 'EUR18');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, 'EUR39', 'EUR');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (20, 18, 'EUR18', 'EUR18');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (33, NULL, 'EUR35', 'EUR36');
INSERT INTO "products" ("productid", "description") VALUES (22, 'EUR18');
INSERT INTO "products" ("productid", "description") VALUES (21, 'EUR18');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (27, '1000-01-29', 'EUR29', 18, 30, 33, 31, 32, 19822);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (53, '1000-02-24', 'EUR55', 18, 56, NULL, 58, 59, 0);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (18, 'EUR18', 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(19822.0,)
*/

-- Prediction Query
SELECT AVG(T2.Price) FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR';

/*
Prediction Result:
(9911.0,)
*/