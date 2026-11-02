-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'OTHER', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (6, NULL, 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'SME');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 2, 'CZE', 'LAM');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (30, 3, 'CZE', 'KAM');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-05-01', '10:00', 1, 1, 10, 100, 500, 1000.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2013-05-01', '10:00', 1, 1, 10, 100, 900, 1800.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '201201', 40.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '201202', 40.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (2, '201301', 90.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '201112', 500.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '992012', 500.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (3, '201206', 200.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (3, '201306', 150.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (3, '201406', 900.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (4, '201211', 300.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (4, '201311', 370.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (5, '201201', 100.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (5, '201301', 400.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (6, '201201', 100.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (6, '201301', 400.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0))) AS REAL) * 100 / SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID;

/*
Gold Result:
(12.5, -25.0, 23.333333333333332)
*/

-- Prediction Query
SELECT T1.Segment, MAX(T2.PercentageIncrease) AS MaxPercentageIncrease, MIN(T2.PercentageIncrease) AS MinPercentageIncrease FROM customers AS T1 INNER JOIN (SELECT T3.Segment, (SUM(IIF(SUBSTRING(T4.Date, 1, 4) = '2013', T4.Consumption, 0)) - SUM(IIF(SUBSTRING(T4.Date, 1, 4) = '2012', T4.Consumption, 0))) * 100 / SUM(IIF(SUBSTRING(T4.Date, 1, 4) = '2013', T4.Consumption, 0)) AS PercentageIncrease FROM customers AS T3 INNER JOIN yearmonth AS T4 ON T3.CustomerID = T4.CustomerID WHERE T3.Currency = 'EUR' GROUP BY T3.Segment) AS T2 ON T1.Segment = T2.Segment GROUP BY T1.Segment;

/*
Prediction Result:
('KAM', 18.91891891891892, 18.91891891891892)
('LAM', -33.333333333333336, -33.333333333333336)
('OTHER', 75.0, 75.0)
('SME', None, None)
*/