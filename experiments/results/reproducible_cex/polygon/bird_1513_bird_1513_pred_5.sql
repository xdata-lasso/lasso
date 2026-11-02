-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (16, '17', '17');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (15, '17', '17');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (18, 17, '17', '17');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, NULL, NULL, NULL);
INSERT INTO "products" ("productid", "description") VALUES (20, '17');
INSERT INTO "products" ("productid", "description") VALUES (19, '17');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (35, '2012-08-25', '36', 37, 38, 17, 39, 40, 1);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '2012-08-25', NULL, NULL, NULL, 17, NULL, NULL, -3);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (16, '23', 17);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (16, '22', 17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' ORDER BY T1.Time DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT g.Country FROM transactions_1k AS t INNER JOIN gasstations AS g ON t.GasStationID = g.GasStationID WHERE t.Date = '2012-08-25' AND t.Price > 0 ORDER BY t.Time ASC, t.transactionid NULLS LAST, g.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/