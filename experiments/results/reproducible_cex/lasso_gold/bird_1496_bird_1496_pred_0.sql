-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1027, 'agreement', 'option');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1028, 'agreement', 'decide');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1029, 'agreement', 'sense');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1030, 'agreement', 'rate');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1035, 'discussion', 'list');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1036, 'discussion', 'perform');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1037, 'discussion', 'fall');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1038, 'discussion', 'table');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1043, 'discussion', 'sure');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1044, 'discussion', 'collection');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1045, 'discussion', 'save');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1046, 'discussion', 'knowledge');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1027, '201309', 1031.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1027, 'science', 1038.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1027, 'offer', 1045.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1027, 'kind', 1052.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1035, '201309', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1035, 'true', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1035, 'according', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1035, 'song', NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1043, '201309', 1047.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1043, 'grow', 1054.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1043, 'clearly', 1061.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1043, 'dinner', 1068.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('discussion',)
*/

-- Prediction Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.Segment ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Prediction Result:
('agreement',)
*/