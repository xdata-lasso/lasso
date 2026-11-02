-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic calculation, non-terminating decimal division (integer vs float division), and multiple records per customer/year.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'USD');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202', 200.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 400.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201205', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201305', 250.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201212', 80.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201312', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0))) AS REAL) * 100 / SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID;

/*
Gold Result:
(33.333333333333336, -50.0, 25.0)
*/

-- Prediction Query
SELECT T1.Segment, MAX(T2.PercentageIncrease) AS MaxPercentageIncrease, MIN(T2.PercentageIncrease) AS MinPercentageIncrease FROM customers AS T1 INNER JOIN (SELECT T3.Segment, (SUM(IIF(SUBSTRING(T4.Date, 1, 4) = '2013', T4.Consumption, 0)) - SUM(IIF(SUBSTRING(T4.Date, 1, 4) = '2012', T4.Consumption, 0))) * 100 / SUM(IIF(SUBSTRING(T4.Date, 1, 4) = '2013', T4.Consumption, 0)) AS PercentageIncrease FROM customers AS T3 INNER JOIN yearmonth AS T4 ON T3.CustomerID = T4.CustomerID WHERE T3.Currency = 'EUR' GROUP BY T3.Segment) AS T2 ON T1.Segment = T2.Segment GROUP BY T1.Segment;

/*
Prediction Result:
('LAM', -100.0, -100.0)
('SME', 25.0, 25.0)
*/