-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', 'EUR', NULL, 0, NULL, NULL, NULL, 1.0), (1, '2023-01-01', 'default1', 1, 0, 0, 0, NULL, 0.0), (2, NULL, 'default2', NULL, 1, 1, NULL, NULL, 0.0), (3, '2023-01-01', NULL, 1, 1, 1, 0, NULL, NULL), (4, NULL, NULL, 1, NULL, 1, 1, NULL, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, 'default1', NULL), (0, NULL, 'EUR', 'default1'), (2, 0, 'default2', 'default2'), (3, 1, NULL, 'EUR'), (4, 0, 'default2', 'EUR'), (5, NULL, 'EUR', 'default1'), (6, 0, 'default2', 'default2'), (7, 0, 'default2', NULL), (8, 0, NULL, 'EUR'), (9, 1, 'default1', 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (0, NULL, 'EUR'), (1, NULL, 'EUR'), (2, NULL, NULL), (3, 'default1', 'default1'), (4, 'EUR', 'default2'), (5, 'default1', NULL), (6, 'default2', 'default1'), (7, 'EUR', 'EUR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.ChainID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.Currency = 'EUR';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.ChainID FROM customers AS T1 INNER JOIN transactions_1k AS T3 ON T1.CustomerID = T3.CustomerID INNER JOIN gasstations AS T2 ON T3.GasStationID = T2.GasStationID WHERE T1.Currency = 'EUR';

/*
Prediction Result:
(None,)
(None,)
(None,)
*/