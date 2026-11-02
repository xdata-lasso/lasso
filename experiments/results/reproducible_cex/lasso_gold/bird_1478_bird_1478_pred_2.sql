-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1025, 'science', 'offer');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1026, 'science', 'kind');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1027, 'science', 'discussion');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1028, 'science', 'list');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1033, 'according', 'song');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1034, 'according', 'sure');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1035, 'according', 'collection');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1036, 'according', 'save');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1025, 'perform', 1029.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1025, 'fall', 1036.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1025, 'table', 1043.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1025, 'true', 1050.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1033, 'knowledge', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1033, 'grow', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1033, 'clearly', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1033, 'dinner', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID GROUP BY T1.Segment ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('according',)
*/

-- Prediction Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE NOT T2.Consumption IS NULL GROUP BY T1.Segment ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Prediction Result:
('science',)
*/