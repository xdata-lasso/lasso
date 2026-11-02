-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', 'default2', NULL, NULL, NULL, NULL, NULL, 0.0), (1, NULL, NULL, NULL, NULL, 1, 1, 0, 1.0), (2, '2023-01-01', 'EUR', 0, 0, NULL, 1, NULL, NULL), (3, '2023-01-01', 'default2', NULL, 1, 1, 1, NULL, 1.0), (4, '2023-01-01', 'EUR', 0, 1, NULL, 1, 1, 0.0), (5, '2023-01-01', 'default1', NULL, 0, 0, 0, 1, NULL), (6, NULL, 'EUR', NULL, 0, NULL, 1, 0, 0.0), (7, '2023-01-01', NULL, 1, 1, NULL, 1, 1, 0.0), (8, NULL, 'default1', NULL, 1, 0, 0, NULL, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, 'default1', 'default1'), (0, 0, 'default1', 'default2'), (2, 1, NULL, 'default1'), (3, 1, 'default1', 'EUR'), (4, 1, 'EUR', 'default2'), (5, 1, 'default2', 'default1'), (6, NULL, 'EUR', 'default1'), (7, NULL, 'EUR', 'EUR'), (8, 0, 'EUR', 'default1'), (9, NULL, NULL, 'default2'), (10, 0, 'EUR', 'default1'), (11, 1, NULL, 'default2'), (12, NULL, 'default2', 'default1'), (13, 0, 'default2', 'default1'), (14, 1, 'default2', NULL), (15, 0, NULL, NULL), (16, 1, 'default1', 'EUR'), (17, 1, NULL, 'default2'), (18, NULL, NULL, NULL), (19, NULL, 'default2', 'default1'), (20, 1, 'default2', 'default2'), (21, 1, 'default2', 'default2'), (22, NULL, 'default1', 'EUR'), (23, 1, 'default1', 'default2'), (24, 1, 'default2', NULL), (25, NULL, NULL, NULL), (26, 1, NULL, 'EUR');
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default1', 'EUR'), (0, NULL, 'EUR'), (2, 'default2', 'default1'), (3, 'default1', 'EUR'), (4, 'default1', 'default1'), (5, 'default1', 'EUR'), (6, 'default2', 'EUR'), (7, NULL, 'EUR'), (8, 'default2', 'default2'), (9, 'EUR', 'default2'), (10, 'default2', NULL), (11, 'default2', 'EUR'), (12, 'default2', 'EUR'), (13, 'default2', 'default1'), (14, 'EUR', 'default1'), (15, 'default2', 'default2'), (16, 'default2', 'default1'), (17, NULL, 'EUR'), (18, 'default1', 'EUR'), (19, 'EUR', 'default1'), (20, NULL, NULL), (21, NULL, NULL), (22, 'default2', 'default1'), (23, 'EUR', 'default1'), (24, 'default1', 'default2'), (25, 'default1', NULL), (26, 'default1', NULL), (27, NULL, 'default1'), (28, NULL, 'default1'), (29, 'default1', 'default2'), (30, 'default2', 'default1'), (31, 'default2', NULL), (32, 'default1', 'EUR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(T2.Price) FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR';

/*
Prediction Result:
(0.0,)
*/