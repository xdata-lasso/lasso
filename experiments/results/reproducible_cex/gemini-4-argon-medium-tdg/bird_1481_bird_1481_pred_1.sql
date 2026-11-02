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
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'OTHER', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'SME', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201302', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201303', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201306', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201312', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201305', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201308', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201212', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201401', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201305', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201309', 250.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(14.285714285714281, 14.285714285714286, -28.57142857142857)
*/

-- Prediction Query
SELECT (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) - (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) AS diff1, (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) - (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) AS diff2, (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) - (SELECT AVG(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME' AND T1.Currency = 'CZK' AND T2.Date LIKE '2013%' ORDER BY T2.Consumption ASC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1) AS diff3;

/*
Prediction Result:
(0.0, -75.0, 75.0)
*/