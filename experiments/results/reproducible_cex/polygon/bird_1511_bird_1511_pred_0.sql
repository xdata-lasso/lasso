-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (19, 'EUR18', 'EUR18');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, 'EUR50', 'Euro');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (34, 35, 'EUR36', 'Euro37');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (44, 45, 'EUR46', 'Euro47');
INSERT INTO "products" ("productid", "description") VALUES (21, 'EUR18');
INSERT INTO "products" ("productid", "description") VALUES (20, 'EUR18');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (28, '1000-01-30', 'EUR30', 18, 31, 34, 32, 33, -1674);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (38, '1000-02-09', 'EUR40', 18, 41, 44, 42, 43, -317);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (19, 'Euro23', 18);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (18, 'EUR22', 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(T4.Price) FROM customers AS T1 INNER JOIN "transactions_1k" AS T4 ON T1.CustomerID = T4.CustomerID WHERE T1.Currency = 'Euro';

/*
Prediction Result:
(-995.5,)
*/