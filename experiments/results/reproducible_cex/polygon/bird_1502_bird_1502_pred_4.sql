-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (21, 'EUR20', 'EUR20');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (20, 'EUR28', 'Euro');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (38, 31, 'EUR32', 'Euro33');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (48, 31, 'EUR42', 'Euro43');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (44, '1000-02-15', 'EUR46', 20, 47, 48, 49, 50, 51);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (34, '1000-02-05', 'EUR36', 20, 37, 38, 39, 40, 41);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.ChainID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.Currency = 'EUR';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT gasstations.chainid FROM gasstations INNER JOIN transactions_1k ON gasstations.gasstationid = transactions_1k.gasstationid INNER JOIN customers ON transactions_1k.customerid = customers.customerid WHERE customers.currency IN ('Euro', 'EUR');

/*
Prediction Result:
(31,)
*/