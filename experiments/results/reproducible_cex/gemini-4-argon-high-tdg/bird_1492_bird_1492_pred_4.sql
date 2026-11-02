-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'LAM', 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'KAM');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 2, 'SVK', 'SME');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '10:00:00', 1, 1001, 20, 100, 50, 1500.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '11:00:00', 1, 1001, 20, 100, 60, 1800.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '12:00:00', 2, 1002, 10, 100, 40, 1200.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-26', '13:00:00', 4, 1004, 10, 100, 30, 900.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201207', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201208', 600.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201208', 300.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201208', 200.0);
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