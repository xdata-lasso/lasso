-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests floating-point division (1/3 = 33.333...), filtering by Segment = 'KAM', NULL handling in Currency (to kill COUNT(Currency) vs COUNT(CustomerID)), and ignoring other tables.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', NULL);
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (6, NULL, 'EUR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(Currency = 'EUR') AS REAL) * 100 / COUNT(CustomerID) FROM customers WHERE Segment = 'KAM';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN Currency = 'EUR' THEN 1 ELSE 0 END) AS REAL) / COUNT(*)) * 100 AS percentage_of_KAM_uses_Euro FROM customers WHERE Segment = 'KAM';

/*
Prediction Result:
(33.33333333333333,)
*/