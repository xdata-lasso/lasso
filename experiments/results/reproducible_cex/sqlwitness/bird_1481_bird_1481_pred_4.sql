-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'KAM', 'LAM'), (3, '2013', NULL), (201302, 'LAM', 'CZK'), (4, 'SME', 'SME'), (201311, 'KAM', 'CZK'), (-1, 'default2', 'CZK'), (2, 'CZK', 'KAM'), (5, 'KAM', 'LAM'), (201312, NULL, 'default1'), (201313, 'LAM', NULL), (1, 'CZK', 'LAM'), (201301, NULL, 'default2'), (201300, 'CZK', 'LAM'), (6, 'SME', 'default2'), (7, '2013', 'LAM'), (8, 'CZK', 'LAM'), (9, NULL, 'default1'), (10, 'KAM', 'LAM');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (201302, 'LAM', 201312.0), (201312, 'default2', 201301.0), (5, '2013', 201302.0), (3, 'default1', 1.0), (7, 'SME', 201301.0), (2, 'default2', 1.0), (3, '2013', -1.0), (201313, 'KAM', -1.0), (-1, 'KAM', 201311.0), (0, 'default2', 201313.0), (3, 'KAM', 201302.0), (5, 'LAM', 201302.0), (201312, 'LAM', 0.0), (6, '2013', 3.0), (2, 'KAM', 201312.0), (7, 'default2', 201301.0), (1, 'default2', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
SELECT AVG(CASE WHEN customers.Segment = 'SME' THEN yearmonth.Consumption END) - AVG(CASE WHEN customers.Segment = 'LAM' THEN yearmonth.Consumption END) AS Difference_SME_LAM, AVG(CASE WHEN customers.Segment = 'LAM' THEN yearmonth.Consumption END) - AVG(CASE WHEN customers.Segment = 'KAM' THEN yearmonth.Consumption END) AS Difference_LAM_KAM, AVG(CASE WHEN customers.Segment = 'KAM' THEN yearmonth.Consumption END) - AVG(CASE WHEN customers.Segment = 'SME' THEN yearmonth.Consumption END) AS Difference_KAM_SME FROM yearmonth JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE SUBSTRING(yearmonth."Date", 1, 4) = '2013';

/*
Prediction Result:
(None, None, 201299.0)
*/