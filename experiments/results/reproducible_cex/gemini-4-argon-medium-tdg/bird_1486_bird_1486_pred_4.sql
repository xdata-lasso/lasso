-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', NULL);
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', NULL);
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'LAM', 'EUR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST((SELECT COUNT(DISTINCT CustomerID) FROM customers WHERE Segment = 'SME' AND Currency = 'CZK') AS REAL) - CAST((SELECT COUNT(DISTINCT CustomerID) FROM customers WHERE Segment = 'SME' AND Currency = 'EUR') AS REAL) AS more_smes;

/*
Prediction Result:
(0.0,)
*/