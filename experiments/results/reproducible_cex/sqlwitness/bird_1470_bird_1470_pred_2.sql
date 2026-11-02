-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', 'default1', 0, 0, NULL, NULL, 1, 1.0), (1, '2023-01-01', NULL, 0, 0, NULL, NULL, 0, NULL), (2, NULL, 'default2', 0, 1, NULL, 0, NULL, 1.0), (3, '2023-01-01', NULL, NULL, 1, NULL, 1, NULL, 0.0);
INSERT INTO products (productid, description) VALUES (0, 'default1'), (1, 'Premium');
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 0, 'CZE', 'Premium'), (0, 0, 'default1', 'CZE'), (2, 0, 'default1', 'default2'), (3, 0, 'Premium', 'CZE'), (4, 1, 'CZE', 'CZE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(GasStationID) FROM gasstations WHERE Country = 'CZE' AND Segment = 'Premium';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT g.GasStationID) FROM gasstations AS g JOIN transactions_1k AS t ON g.GasStationID = t.GasStationID JOIN products AS p ON t.ProductID = p.ProductID WHERE g.Country = 'CZE' AND (p.Description = 'Premium' OR g.Segment = 'Premium');

/*
Prediction Result:
(0,)
*/