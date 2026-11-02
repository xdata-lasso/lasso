-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests GROUP BY T1.CustomerID vs GROUP BY T1.Segment.
-- Two 'SME' customers each have Consumption 60 (Sum per customer = 60, Sum per segment = 120).
-- One 'KAM' customer has Consumption 100 (Sum per customer = 100, Sum per segment = 100).
-- Gold Query (GROUP BY CustomerID) returns 'SME' (min is 60). Mutant (GROUP BY Segment) returns 'KAM' (min is 100).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201309', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201309', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201309', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('SME',)
*/

-- Prediction Query
SELECT "customers"."segment" FROM "yearmonth" INNER JOIN "customers" ON "yearmonth"."customerid" = "customers"."customerid" WHERE "yearmonth"."date" = '201309' GROUP BY "customers"."segment" ORDER BY SUM("yearmonth"."consumption") ASC, "customers"."segment" NULLS LAST LIMIT 1;

/*
Prediction Result:
('KAM',)
*/