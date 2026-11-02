-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (2, 'SME', NULL), (1, '201301', 'SME'), (5, 'SME', '201301'), (3, '201301', 'default2'), (13, '201312', NULL), (4, '201312', 'default2'), (0, 'default2', NULL), (12, 'default1', 'default2'), (11, 'default1', '201301');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (13, '201301', 0.0), (0, '201312', 12.0), (12, '201312', 12.0), (2, '201312', 4.0), (2, 'default1', 5.0), (13, 'SME', 12.0), (0, '2013', 2.0), (5, '2013', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.Consumption) / 12 FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME';

/*
Gold Result:
(0.25,)
*/

-- Prediction Query
SELECT AVG("yearmonth"."consumption") / 12 FROM "yearmonth" INNER JOIN "customers" ON "yearmonth"."customerid" = "customers"."customerid" WHERE "customers"."segment" = 'SME' AND "yearmonth"."date" BETWEEN '201301' AND '201312';

/*
Prediction Result:
(0.3333333333333333,)
*/