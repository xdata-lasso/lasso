-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (201300, 'default2', 'SME'), (1, 'default2', 'LAM'), (201313, 'LAM', 'default1'), (201301, 'KAM', 'default2'), (201302, 'default1', 'default2'), (2, 'SME', '201312'), (201312, 'KAM', 'LAM'), (201311, 'default2', '201312'), (-1, 'KAM', 'default1'), (0, 'SME', 'KAM'), (3, NULL, 'SME'), (4, 'default2', 'default2'), (5, 'LAM', '201301'), (6, 'default1', '201301'), (7, NULL, 'CZK'), (8, '201312', 'KAM'), (9, 'default1', '201312'), (10, '201301', '201301'), (11, '201301', 'default1'), (12, '201301', 'KAM'), (13, NULL, NULL), (14, '201312', 'CZK'), (15, '201312', NULL), (16, '201312', 'LAM'), (17, 'KAM', 'default2'), (18, 'SME', 'LAM'), (19, '201312', '201301'), (20, '201301', 'default2'), (21, 'default2', '201312'), (22, '201301', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (7, 'LAM', 201301.0), (3, '201312', 201312.0), (201311, '201312', 201313.0), (201301, 'SME', 201313.0), (7, 'default1', 2.0), (12, 'LAM', 201300.0), (0, '201312', 2.0), (-1, '201312', 201312.0), (6, '201301', 201301.0), (201313, 'KAM', 201301.0), (17, 'default1', 201300.0), (201301, 'KAM', 201311.0), (201312, '201301', 201312.0), (21, '201312', 1.0), (201312, 'SME', 201311.0), (201311, 'SME', 201302.0), (16, 'default2', 201312.0), (22, 'KAM', 201313.0), (4, 'LAM', 201311.0), (-1, 'KAM', 201312.0), (-1, 'LAM', 1.0), (9, '201312', 1.0), (1, 'SME', NULL), (14, 'LAM', 2.0), (21, 'default2', 2.0), (19, '201312', -1.0), (18, 'LAM', 201300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
WITH lowest_consumption_customers AS (SELECT ym.CustomerID, ym."Date", ym.Consumption, c.Segment, ROW_NUMBER() OVER (PARTITION BY c.Segment ORDER BY ym.Consumption ASC) AS rn FROM yearmonth AS ym JOIN customers AS c ON ym.CustomerID = c.CustomerID WHERE ym."Date" BETWEEN '201301' AND '201312'), segment_consumption AS (SELECT lcc.Segment, SUM(lcc.Consumption) AS TotalConsumption, COUNT(lcc.CustomerID) AS NumberOfCustomers FROM lowest_consumption_customers AS lcc WHERE lcc.rn = 1 GROUP BY lcc.Segment) SELECT (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'SME') - (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'LAM') AS SME_LAM_Difference, (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'LAM') - (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'KAM') AS LAM_KAM_Difference, (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'KAM') - (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'SME') AS KAM_SME_Difference;

/*
Prediction Result:
(None, None, 201310.0)
*/