-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default2', NULL), (2, '201309', NULL), (1, 'default1', 'default1'), (3, NULL, '201309'), (4, 'default2', 'default2'), (5, '201309', '201309'), (6, '201309', 'default2'), (7, NULL, 'default1'), (8, NULL, 'default2'), (9, '201309', '201309'), (10, 'default2', 'default1'), (11, 'default1', NULL), (12, NULL, 'default2'), (13, NULL, 'default2'), (14, 'default2', '201309'), (15, 'default1', '201309'), (16, NULL, '201309'), (17, NULL, NULL), (18, 'default2', '201309'), (19, '201309', '201309'), (20, NULL, NULL), (21, 'default2', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (8, '201309', 1.0), (15, '201309', 0.0), (5, '201309', 0.0), (10, 'default2', 1.0), (6, '201309', NULL), (17, 'default1', 2.0), (0, 'default1', NULL), (14, 'default1', 2.0), (9, '201309', 1.0), (10, 'default1', NULL), (4, '201309', 1.0), (0, '201309', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('201309',)
*/

-- Prediction Query
SELECT "customers"."segment" FROM "yearmonth" INNER JOIN "customers" ON "yearmonth"."customerid" = "customers"."customerid" WHERE "yearmonth"."date" = '201309' GROUP BY "customers"."segment" ORDER BY SUM("yearmonth"."consumption") ASC, "customers"."segment" NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/