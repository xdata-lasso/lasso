-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 10, 'AUT', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 10, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, NULL, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (4, 20, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (5, 30, 'SVK', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (6, 30, 'SVK', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (7, 40, 'DEU', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (8, 40, 'DEU', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (9, 40, 'DEU', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 40, 'DEU', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (11, 10, 'AUT', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (12, 10, 'AUT', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Country, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country ORDER BY COUNT(GasStationID) DESC, Country NULLS LAST, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') NULLS LAST LIMIT 1;

/*
Gold Result:
('CZE', 6)
*/

-- Prediction Query
SELECT Country, COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country ORDER BY COUNT(GasStationID) DESC, Country NULLS LAST LIMIT 1;

/*
Prediction Result:
('CZE', 3)
*/