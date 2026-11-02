-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1260, 'group', 'arm');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1261, 'manage', 'report');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1262, 'treat', 'ready');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1263, 'shoulder', 'race');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1268, 'cover', 'boy');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1269, 'treat', 'energy');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1270, 'such', 'dark');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1271, 'training', 'not');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1260, '201309', 1264.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1260, 'billion', 1271.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1260, 'ask', 1278.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1260, 'interesting', 1285.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1268, '201309', 1264.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1268, 'list', 1279.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1268, 'challenge', 1286.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1268, 'knowledge', 1293.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('cover',)
*/

-- Prediction Query
SELECT T2.Segment FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201309' ORDER BY T1.Consumption ASC, T1.date NULLS LAST, T1.customerid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
('group',)
*/