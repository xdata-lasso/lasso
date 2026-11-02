-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. GROUP BY SUBSTRING(T2.Date, 1, 4) vs GROUP BY T2.Date (2012 has two different months that sum to 160, beating 2013's single month of 150).
-- 2. SUM(T2.Consumption) vs MAX(T2.Consumption), AVG(T2.Consumption), COUNT(*) (2013 has max single row 150 and avg 150; 2014 has count 3 rows).
-- 3. WHERE T1.Currency = 'CZK' filter (including 'EUR' and NULL which would flip the winner to 2015 if unfiltered).
-- 4. ORDER BY SUM(T2.Consumption) DESC vs ASC (2014 has the lowest sum of 30).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', NULL);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 80.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202', 80.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 150.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201401', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201402', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201403', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201501', 1000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201502', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('2012',)
*/

-- Prediction Query
SELECT STRFTIME('%Y', T2.Date) AS Year FROM yearmonth AS T2 JOIN customers AS T1 ON T2.CustomerID = T1.CustomerID WHERE T1.Currency = 'CZK' GROUP BY Year ORDER BY SUM(T2.Consumption) DESC, Year NULLS LAST LIMIT 1;

/*
Prediction Result:
('-4161',)
*/