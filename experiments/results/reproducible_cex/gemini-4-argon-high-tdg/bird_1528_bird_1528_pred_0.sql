-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'Premium', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'Discount', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 10, 'SVK', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 10, 'SVK', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 20, 'SVK', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (4, 20, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (5, 30, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (6, 30, 'HUN', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (7, 40, 'HUN', 'Other');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '10:00:00', 1, 101, 2, 1, 50, 75.5);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-24', '11:00:00', 1, 101, 2, 1, 30, 45.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '12:00:00', 2, 102, 4, 1, 40, 60.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '201208', 80.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (2, '201208', 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Country = 'SVK' AND Segment = 'Premium', 1, 0)) AS REAL) * 100 / SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations;

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN Segment = 'premium' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM gasstations WHERE Country = 'SVK';

/*
Prediction Result:
(0.0,)
*/