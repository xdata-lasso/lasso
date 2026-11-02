-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- General comprehensive dataset: Tests integer vs float division (100/3 = 33.3333 vs 33),
-- Country filtering vs total row count, NULL handling, and unreferenced tables with different counts.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO products (ProductID, Description) VALUES (10, 'Diesel');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 10, 'SVK', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 10, 'SVK', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 11, 'SVK', NULL);
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (4, 12, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (5, 12, 'CZE', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (6, 13, NULL, 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (7, NULL, NULL, NULL);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (100, '2022-01-01', '12:00:00', 1, 1001, 1, 10, 50, 75.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (101, '2022-01-02', '13:00:00', 1, 1001, 1, 10, 40, 60.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '202201', 90.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Country = 'SVK' AND Segment = 'Premium', 1, 0)) AS REAL) * 100 / SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations;

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN Segment = 'Premium' THEN 1 ELSE 0 END) AS REAL) / COUNT(*)) * 100 AS premium_percentage FROM gasstations WHERE Country = 'SVK';

/*
Prediction Result:
(33.33333333333333,)
*/