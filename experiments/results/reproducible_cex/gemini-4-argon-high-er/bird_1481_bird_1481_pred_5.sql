-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'CZK');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201301', 20.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201301', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(10.0, 0.0, -10.0)
*/

-- Prediction Query
WITH leastconsumption AS (SELECT c.segment, MIN(y.consumption) AS minconsumption FROM customers AS c INNER JOIN yearmonth AS y ON c.customerid = y.customerid WHERE SUBSTRING(y.date, 1, 4) = '2013' AND c.currency = 'CZK' GROUP BY c.segment), annualaverage AS (SELECT c.segment, SUM(y.consumption) / COUNT(DISTINCT c.customerid) AS avgconsumption FROM customers AS c INNER JOIN yearmonth AS y ON c.customerid = y.customerid WHERE SUBSTRING(y.date, 1, 4) = '2013' AND c.currency = 'CZK' AND y.consumption = (SELECT minconsumption FROM leastconsumption AS lc WHERE lc.segment = c.segment) GROUP BY c.segment) SELECT (SELECT avgconsumption FROM annualaverage WHERE segment = 'SME') - (SELECT avgconsumption FROM annualaverage WHERE segment = 'LAM') AS sme_lam_difference, (SELECT avgconsumption FROM annualaverage WHERE segment = 'LAM') - (SELECT avgconsumption FROM annualaverage WHERE segment = 'KAM') AS lam_kam_difference, (SELECT avgconsumption FROM annualaverage WHERE segment = 'KAM') - (SELECT avgconsumption FROM annualaverage WHERE segment = 'SME') AS kam_sme_difference;

/*
Prediction Result:
(-10.0, -10.0, 20.0)
*/