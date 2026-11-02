-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, '201301', 'LAM');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
WITH MinConsumption AS (SELECT c.Segment, y.CustomerID, SUM(y.Consumption) AS TotalConsumption FROM yearmonth AS y JOIN customers AS c ON y.CustomerID = c.CustomerID WHERE c.Currency = 'CZK' AND y.Date BETWEEN '201301' AND '201312' GROUP BY c.Segment, y.CustomerID), LeastConsumption AS (SELECT Segment, MIN(TotalConsumption) AS MinTotalConsumption FROM MinConsumption GROUP BY Segment), AvgConsumption AS (SELECT mc.Segment, AVG(mc.TotalConsumption) AS AvgConsumption FROM MinConsumption AS mc JOIN LeastConsumption AS lc ON mc.Segment = lc.Segment AND mc.TotalConsumption = lc.MinTotalConsumption GROUP BY mc.Segment) SELECT c1.Segment AS Segment1, c2.Segment AS Segment2, CAST(c1.AvgConsumption AS REAL) - CAST(c2.AvgConsumption AS REAL) AS Difference FROM AvgConsumption AS c1 JOIN AvgConsumption AS c2 ON (c1.Segment = 'SME' AND c2.Segment = 'LAM') OR (c1.Segment = 'LAM' AND c2.Segment = 'KAM') OR (c1.Segment = 'KAM' AND c2.Segment = 'SME');

/*
Prediction Result:
*/