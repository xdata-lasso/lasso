-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 1, 'SVK', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, NULL, 'SVK', NULL);
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 2, NULL, 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (4, NULL, NULL, NULL);
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (5, 3, 'SVK', 'Non-Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (6, 4, 'svk', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (7, 5, 'SVK', 'premium');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Country = 'SVK' AND Segment = 'Premium', 1, 0)) AS REAL) * 100 / SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations;

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN Segment = 'Premium' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(Segment) FROM gasstations WHERE Country = 'SVK';

/*
Prediction Result:
(33.333333333333336,)
*/