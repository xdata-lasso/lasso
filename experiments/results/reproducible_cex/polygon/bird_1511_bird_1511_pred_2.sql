-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (56, 'Euro57', 'Euro');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (18, 56, 'EUR56', 'EUR56');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (53, 31, 'EUR32', 'Euro33');
INSERT INTO "products" ("productid", "description") VALUES (20, 'EUR56');
INSERT INTO "products" ("productid", "description") VALUES (19, 'EUR56');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (25, '1000-01-27', 'Euro27', 56, 28, 53, 29, 30, -903);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (49, '1000-02-20', 'Euro51', 56, 52, 53, 54, 55, -1088);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (56, 'EUR56', 56);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'Euro';

/*
Prediction Result:
(-995.5,)
*/