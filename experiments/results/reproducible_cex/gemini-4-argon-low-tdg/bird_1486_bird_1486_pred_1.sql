-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests asymmetric counts (3 CZK, 2 EUR), other currencies ('USD'), NULL currencies,
-- other segments ('KAM', 'LAM'), NULL segments, and unreferenced vs referenced customers in child tables.
-- Gold result: 3 - 2 = 1.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (6, 'SME', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (7, 'SME', NULL);
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (8, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (9, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (10, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (11, NULL, 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (101, 1, 'CZE', 'SME');
INSERT INTO products (ProductID, Description) VALUES (201, 'Diesel');
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2020-01-01', '12:00', 1, 1001, 101, 201, 50, 1500.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2020-01-02', '13:00', 1, 1001, 101, 201, 60, 1800.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '202001', 110.0);
INSERT INTO "yearmonth" (CustomerID, Date, Consumption) VALUES (1, '202002', 90.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN c.Currency = 'CZK' THEN t.Amount ELSE 0 END) - SUM(CASE WHEN c.Currency = 'EUR' THEN t.Amount ELSE 0 END) AS AmountDifference FROM customers AS c INNER JOIN transactions_1k AS t ON c.CustomerID = t.CustomerID WHERE c.Segment = 'SME';

/*
Prediction Result:
(110,)
*/