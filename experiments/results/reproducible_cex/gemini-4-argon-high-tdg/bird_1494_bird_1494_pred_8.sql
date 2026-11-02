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
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'Discount', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'Premium', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'SVK', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 1, 'SVK', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (30, NULL, 'SVK', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (40, 2, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (50, 2, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (60, 3, NULL, 'Premium');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '10:00:00', 1, 111, 20, 100, 50, 75.5);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-24', '11:00:00', 1, 111, 20, 100, 40, 60.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '12:00:00', 2, 222, 30, 100, 30, 45.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-25', '13:00:00', 3, 333, 40, 100, 20, 30.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '201208', 90.0);
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