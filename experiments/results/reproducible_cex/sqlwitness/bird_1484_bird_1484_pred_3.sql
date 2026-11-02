-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (2, 1, 'Slovakia', 'CZE'), (1, -1, 'default2', NULL), (0, 2, NULL, 'Czech Republic'), (-1, 2, 'Czech Republic', 'SVK'), (3, 0, 'default2', 'default2'), (4, -1, 'default2', 'Discount'), (5, 1, 'CZE', 'CZE'), (6, -1, 'Discount', NULL), (7, 2, 'default1', 'Czech Republic'), (8, 2, 'Slovakia', 'Discount');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(Country = 'CZE', 1, 0)) - SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations WHERE Segment = 'Discount';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT SUM(IIF(Country = 'Czech Republic', 1, 0)) - SUM(IIF(Country = 'Slovakia', 1, 0)) FROM gasstations WHERE Segment = 'Discount';

/*
Prediction Result:
(-1,)
*/