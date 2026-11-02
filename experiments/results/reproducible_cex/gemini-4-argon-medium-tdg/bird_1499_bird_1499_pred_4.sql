-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: SUM vs AVG/MAX/MIN, GROUP BY CustomerID vs Segment/Currency, WHERE Currency = 'EUR' vs other/NULL, ORDER BY DESC vs ASC, LIMIT 1.
-- Customer 1 (EUR): 3 rows summing to 180 (Monthly = 15.0, AVG = 60, MAX = 100)
-- Customer 2 (EUR): 1 row of 120 (Monthly = 10.0, AVG = 120, MAX = 120) -> Kills AVG/MAX mutants because Cust 2 has higher AVG/MAX than Cust 1, but Cust 1 has higher SUM.
-- Customer 3 (USD): 1 row of 1200 (Monthly = 100.0) -> Kills missing WHERE Currency = 'EUR' mutant.
-- Customer 4 (NULL): 1 row of 2400 -> Kills NULL handling mutants.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'LAM', NULL);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202', 50.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201203', 30.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 120.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201', 1200.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201201', 2400.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) / 12 AS MonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY T1.CustomerID ORDER BY MonthlyConsumption DESC LIMIT 1;

/*
Gold Result:
(15.0,)
*/

-- Prediction Query
SELECT MAX(T1.Consumption) FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR';

/*
Prediction Result:
(120.0,)
*/