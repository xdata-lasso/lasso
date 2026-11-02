-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (18, 'EUR38', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (58, 'EUR59', 'EUR');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (56, 28, 'EUR29', 'EUR30');
INSERT INTO "products" ("productid", "description") VALUES (20, 'EUR58');
INSERT INTO "products" ("productid", "description") VALUES (19, 'EUR58');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (52, '1000-02-23', 'EUR54', 58, 55, 56, 57, 0, -1);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '1000-02-02', 'EUR33', 18, 34, 31, 35, NULL, 375);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (18, 'EUR23', 58);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (58, 'EUR22', 58);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(-1.0,)
*/

-- Prediction Query
SELECT AVG(CAST(t.Amount * t.Price AS REAL)) AS average_total_price FROM transactions_1k AS t JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'EUR';

/*
Prediction Result:
(0.0,)
*/