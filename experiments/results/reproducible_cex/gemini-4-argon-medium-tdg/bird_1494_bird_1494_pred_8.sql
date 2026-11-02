-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests floating-point division (33.3333...), filtering by Country = 'SVK', Segment = 'Premium', NULL handling in Segment and Country, and joins to transactions_1k or customers.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'Premium', 'EUR');
INSERT INTO products (ProductID, Description) VALUES (1, 'Fuel');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 10, 'SVK', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 10, 'SVK', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 20, 'SVK', NULL);
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (4, 10, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (5, 30, NULL, 'Premium');
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2022-01-01', '10:00:00', 1, 100, 1, 1, 50, 75.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2022-01-02', '11:00:00', 1, 100, 1, 1, 30, 45.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Segment = 'Premium', 1, 0)) AS REAL) * 100 / COUNT(GasStationID) FROM gasstations WHERE Country = 'SVK';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (CAST(COUNT(CASE WHEN Segment = 'Premium' THEN GasStationID END) AS REAL) * 100 / COUNT(GasStationID)) FROM gasstations WHERE Country = 'SLO';

/*
Prediction Result:
(None,)
*/