-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'CZK');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201302', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201303', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201304', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201305', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201306', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201307', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201308', 50.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201309', 75.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201310', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(2.857142857142857, 1.4285714285714286, -4.285714285714286)
*/

-- Prediction Query
SELECT AVG(CASE WHEN customers.Segment = 'SME' THEN yearmonth.Consumption END) - AVG(CASE WHEN customers.Segment = 'LAM' THEN yearmonth.Consumption END) AS Difference_SME_LAM, AVG(CASE WHEN customers.Segment = 'LAM' THEN yearmonth.Consumption END) - AVG(CASE WHEN customers.Segment = 'KAM' THEN yearmonth.Consumption END) AS Difference_LAM_KAM, AVG(CASE WHEN customers.Segment = 'KAM' THEN yearmonth.Consumption END) - AVG(CASE WHEN customers.Segment = 'SME' THEN yearmonth.Consumption END) AS Difference_KAM_SME FROM yearmonth JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE SUBSTRING(yearmonth."Date", 1, 4) = '2013';

/*
Prediction Result:
(-13.666666666666668, -23.333333333333332, 37.0)
*/