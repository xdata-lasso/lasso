-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set for WHERE clause (no 'SME' customers).
-- SUM(...) in SQLite returns NULL when 0 rows match, so NULL - NULL = NULL.
-- Kills mutants using COUNT(...) - COUNT(...) which would return 0 - 0 = 0.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, NULL, 'CZK');
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