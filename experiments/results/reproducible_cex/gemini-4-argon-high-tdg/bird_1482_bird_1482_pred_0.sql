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
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'RML', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (6, NULL, 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'KAM');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 2, 'SVK', 'SME');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-01-15', '10:00:00', 1, 101, 10, 100, 50, 1500.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2013-03-20', '14:30:00', 1, 101, 20, 100, 80, 2400.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201112', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 120.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201206', 80.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201303', 250.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201202', 300.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201301', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201308', 110.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201401', 400.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201205', 400.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201211', 300.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201304', 900.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201201', 1000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201301', 2000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (6, '201201', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (6, '201301', 800.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0))) AS REAL) * 100 / SUM(IIF(T1.Segment = 'SME' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'LAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)), CAST(SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2013%', T2.Consumption, 0)) - SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) AS REAL) * 100 / SUM(IIF(T1.Segment = 'KAM' AND T2.Date LIKE '2012%', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID;

/*
Gold Result:
(25.0, -30.0, 28.571428571428573)
*/

-- Prediction Query
SELECT "segment", MAX(percentage_increase) AS max_increase, MIN(percentage_increase) AS min_increase FROM (SELECT c."segment", ((SUM(CASE WHEN SUBSTRING(y."date", 1, 4) = '2013' THEN y."consumption" ELSE 0 END) - SUM(CASE WHEN SUBSTRING(y."date", 1, 4) = '2012' THEN y."consumption" ELSE 0 END)) / SUM(CASE WHEN SUBSTRING(y."date", 1, 4) = '2013' THEN y."consumption" ELSE 0 END)) * 100 AS percentage_increase FROM "customers" AS c JOIN "yearmonth" AS y ON c."customerid" = y."customerid" WHERE c."currency" = 'EUR' AND c."segment" IN ('SME', 'LAM', 'KAM') GROUP BY c."segment");

/*
Prediction Result:
('SME', 20.0, 20.0)
*/