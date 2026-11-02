-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard evaluation with CZE > SVK, presence of other segments ('Value for money', NULL), other countries ('DEU', NULL), and foreign key interactions (unreferenced stations, multiple transactions per station, customer segment trap).
-- Gold Query Result: 1 (3 CZE Discount - 2 SVK Discount)
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'Discount', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 10, 'CZE', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 10, 'CZE', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 20, 'CZE', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (4, 10, 'SVK', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (5, 30, 'SVK', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (6, 10, 'DEU', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (7, 10, NULL, 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (8, 10, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (9, 10, 'SVK', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 10, 'CZE', NULL);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2023-01-01', '10:00', 1, 100, 1, 1, 50, 1500.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2023-01-02', '11:00', 1, 100, 1, 1, 40, 1200.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2023-01-03', '12:00', 2, 101, 4, 1, 30, 900.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2023-01-04', '13:00', 1, 100, 8, 1, 20, 600.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '202301', 2700.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(Country = 'CZE', 1, 0)) - SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations WHERE Segment = 'Discount';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT SUM(IIF(Country = 'Czech Republic', 1, 0)) - SUM(IIF(Country = 'Slovakia', 1, 0)) FROM gasstations WHERE Segment = 'Discount';

/*
Prediction Result:
(0,)
*/