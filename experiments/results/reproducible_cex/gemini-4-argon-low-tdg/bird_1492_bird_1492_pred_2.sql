-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
-- Tests all NULL currencies for 'KAM' (SUM(Currency = 'EUR') evaluates to NULL rather than 0, testing COALESCE/IFNULL differences).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'KAM', NULL);
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', NULL);
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'EUR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(Currency = 'EUR') AS REAL) * 100 / COUNT(CustomerID) FROM customers WHERE Segment = 'KAM';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(IIF("segment" = 'KAM' AND "currency" = 'EUR', 1, 0)) AS REAL) * 100 / SUM(IIF("segment" = 'KAM', 1, 0)) FROM "customers";

/*
Prediction Result:
(0.0,)
*/