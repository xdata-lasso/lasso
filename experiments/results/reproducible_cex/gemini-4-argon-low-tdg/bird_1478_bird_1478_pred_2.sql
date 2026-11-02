-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests:
-- 1. Handling of NULL and negative/zero values in T2.Consumption.
-- 2. Segment 'A' has all NULL consumptions -> SUM is NULL (in SQLite, NULL sorts first in ASC unless NULLS LAST is specified on the first ORDER BY expr).
-- 3. Segment 'B' has negative consumption (-10.0) vs Segment 'C' (5.0).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'Seg_A', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'Seg_B', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'Seg_C', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', NULL);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', -10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201202', NULL);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID GROUP BY T1.Segment ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('Seg_A',)
*/

-- Prediction Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE NOT T2.Consumption IS NULL GROUP BY T1.Segment ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Prediction Result:
('Seg_B',)
*/