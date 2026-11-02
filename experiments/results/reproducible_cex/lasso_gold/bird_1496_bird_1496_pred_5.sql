-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1292, 'treatment', 'community');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1293, 'institution', 'hundred');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1294, 'weight', 'able');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1295, 'artist', 'in');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1292, '201309 ', 1296.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1292, 'evidence', 1303.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1292, 'with', 1310.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1292, 'step', 1317.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT customers.Segment FROM yearmonth INNER JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE yearmonth."Date" LIKE '201309%' GROUP BY customers.Segment ORDER BY SUM(yearmonth.Consumption) ASC, customers.Segment NULLS LAST LIMIT 1;

/*
Prediction Result:
('treatment',)
*/