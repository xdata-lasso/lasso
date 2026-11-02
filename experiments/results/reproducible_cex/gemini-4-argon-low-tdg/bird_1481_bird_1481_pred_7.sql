-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core dataset: Asymmetric row counts per segment (SME: 2, LAM: 1, KAM: 0, Other: 1), multiple rows for a single customer (tests COUNT vs COUNT DISTINCT), non-integer Consumption and division results (tests CAST AS REAL), and boundary dates (201301, 201312).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'OTHER', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'SME', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 10.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201312', 10.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201306', 10.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201306', 25.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201305', 10.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201305', 10.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201212', 10.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201401', 10.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(2.625, 2.625, -5.25)
*/

-- Prediction Query
WITH lowest_consumption_customers AS (SELECT ym.CustomerID, ym."Date", ym.Consumption, c.Segment, ROW_NUMBER() OVER (PARTITION BY c.Segment ORDER BY ym.Consumption ASC) AS rn FROM yearmonth AS ym JOIN customers AS c ON ym.CustomerID = c.CustomerID WHERE ym."Date" BETWEEN '201301' AND '201312'), segment_consumption AS (SELECT lcc.Segment, SUM(lcc.Consumption) AS TotalConsumption, COUNT(lcc.CustomerID) AS NumberOfCustomers FROM lowest_consumption_customers AS lcc WHERE lcc.rn = 1 GROUP BY lcc.Segment) SELECT (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'SME') - (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'LAM') AS SME_LAM_Difference, (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'LAM') - (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'KAM') AS LAM_KAM_Difference, (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'KAM') - (SELECT TotalConsumption / NumberOfCustomers FROM segment_consumption WHERE Segment = 'SME') AS KAM_SME_Difference;

/*
Prediction Result:
(0.0, -14.5, 14.5)
*/