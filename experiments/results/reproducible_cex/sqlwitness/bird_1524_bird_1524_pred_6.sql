-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-08-24', NULL, NULL, NULL, 1, 1, NULL, 549.4), (1, '2012-08-24', 'default2', NULL, 1, 1, NULL, NULL, 1.0), (2, '2012-08-25', 'default1', 0, 1, 0, 0, NULL, NULL), (3, '2012-08-23', '2012-08-24', NULL, 0, NULL, 1, 0, NULL), (4, NULL, '2012-08-24', 1, 1, NULL, NULL, 0, 0.0), (5, '2012-08-23', 'default2', 0, 0, 1, 0, 0, NULL), (6, NULL, 'default2', 0, NULL, 1, 0, 1, 1.0), (7, '2023-01-02', 'default2', 1, NULL, 0, 1, 0, 548.4), (8, '2012-08-25', '2012-08-24', NULL, NULL, 1, NULL, NULL, 549.4), (9, '2012-08-24', NULL, NULL, 0, 0, 0, 1, 549.4), (10, '2023-01-01', '2012-08-24', NULL, NULL, NULL, 0, 0, 547.4), (11, '2023-01-01', '2012-08-24', NULL, 1, 1, 0, 0, 549.4), (12, NULL, NULL, NULL, 1, NULL, 0, NULL, 0.0), (13, '2012-08-24', '2012-08-24', 0, 1, NULL, NULL, 1, 548.4), (14, '2012-08-25', '2012-08-24', NULL, 1, NULL, NULL, NULL, NULL), (15, '2012-08-24', NULL, 1, 0, 1, NULL, 0, 549.4);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, '2012-08-24', NULL), (1, 0, 'default2', NULL), (2, 0, NULL, 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (1, '2012-08-24', 'default1'), (0, NULL, NULL), (2, 'default2', NULL), (3, 'default1', 'default1'), (4, '2012-08-24', '2012-08-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '2012-08-24' AND T2.Price = 548.4;

/*
Prediction Result:
(None,)
*/