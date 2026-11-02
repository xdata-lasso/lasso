-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, WHERE filters (Segment = 'SME', Year = '2013'), and SUM vs MAX/COUNT/AVG
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, NULL, 'EUR');
-- Month 01 (2013, SME): 2 rows, SUM = 120, MAX = 60, AVG = 60, COUNT = 2
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201301', 60.0);
-- Month 02 (2013, SME): 1 row, SUM = 100, MAX = 100, AVG = 100, COUNT = 1
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201302', 100.0);
-- Month 03 (2013, SME): 3 rows, SUM = 90, MAX = 30, AVG = 30, COUNT = 3
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201303', 30.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201303', 30.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '20130399', 30.0);
-- Month 04 (2013, KAM - should be filtered out): SUM = 500
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201304', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201304', 500.0);
-- Month 05 (2012, SME - should be filtered out): SUM = 600
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201205', 600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 5, 2) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME' GROUP BY SUBSTRING(T2.Date, 5, 2) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 5, 2) NULLS LAST LIMIT 1;

/*
Gold Result:
('01',)
*/

-- Prediction Query
SELECT SUBSTRING(T1.Date, 5, 2) FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Segment = 'SME' AND SUBSTRING(T1.Date, 1, 4) = '2013' ORDER BY T1.Consumption DESC, T1.date NULLS LAST, T1.customerid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
('02',)
*/