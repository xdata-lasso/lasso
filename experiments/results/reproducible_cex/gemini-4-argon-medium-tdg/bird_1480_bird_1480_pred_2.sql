-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests SUM vs MAX/AVG/COUNT, GROUP BY month vs full date, and ORDER BY DESC vs ASC.
-- Month '01' has smaller individual rows (60+60=120) across different days than Month '02' (100).
-- Expected result: '01'
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '20130101', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '20130102', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '20130201', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '20130301', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '20130302', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '20130303', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 5, 2) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME' GROUP BY SUBSTRING(T2.Date, 5, 2) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 5, 2) NULLS LAST LIMIT 1;

/*
Gold Result:
('01',)
*/

-- Prediction Query
SELECT "date" FROM "yearmonth" WHERE "customerid" IN (SELECT "customerid" FROM "customers" WHERE "segment" = 'SME') AND "date" BETWEEN '201301' AND '201312' ORDER BY "consumption" DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
('20130201',)
*/