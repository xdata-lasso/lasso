-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests: Empty result set when no 'EUR' customers exist or no matching yearmonth rows exist, and LEFT JOIN vs INNER JOIN when all 'EUR' customers have no yearmonth records.
-- Customer 1 (EUR) has no rows in yearmonth. (INNER JOIN returns empty; LEFT JOIN returns 1 row with NULL).
-- Customer 2 (CZK) has rows in yearmonth.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'CZK');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 360.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) / 12 AS MonthlyConsumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY T1.CustomerID ORDER BY MonthlyConsumption DESC LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(total_consumption / 12) AS biggest_monthly_consumption FROM (SELECT SUM(yearmonth.consumption) AS total_consumption FROM yearmonth INNER JOIN customers ON yearmonth.customerid = customers.customerid WHERE customers.currency = 'EUR' GROUP BY yearmonth.customerid);

/*
Prediction Result:
(None,)
*/