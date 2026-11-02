-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, 'CZE18', 'CZE18');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, 'CZE18', 'CZE18');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (18, 34, 'CZE', 'CZE35');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, 18, 'CZE18', 'CZE18');
INSERT INTO "products" ("productid", "description") VALUES (20, 'CZE18');
INSERT INTO "products" ("productid", "description") VALUES (19, 'CZE18');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (22, '1000-01-30', 'CZE30', 31, 32, 18, 33, NULL, -413);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '1000-01-19', 'CZE18', 18, 18, NULL, 18, 18, 18);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (15, 'CZE24', 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Gold Result:
(-413.0,)
*/

-- Prediction Query
SELECT AVG(T1.Amount * T1.Price) AS AverageTotalPrice FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Prediction Result:
(None,)
*/