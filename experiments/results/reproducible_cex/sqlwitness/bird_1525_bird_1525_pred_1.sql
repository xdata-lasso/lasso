-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (-1, '2012-08-25', 'EUR', 2, 2, 1, 100, 2, NULL), (0, '2012-08-24', NULL, 1, 2, 100, 100, 2, NULL), (2, '2012-08-25', '2012-08-25', 99, -1, NULL, 99, 0, 100.0), (1, '2023-01-02', NULL, NULL, NULL, 100, 100, NULL, 99.0), (99, NULL, 'default1', 2, NULL, 100, 0, 0, -1.0), (101, '2012-08-24', 'default2', 100, 101, 100, -1, 1, NULL), (100, '2012-08-24', '2012-08-25', 1, 2, NULL, 101, -1, -1.0), (3, '2012-08-24', 'default1', 2, NULL, NULL, 0, NULL, 100.0), (4, '2012-08-24', 'default1', 2, -1, 2, 101, 1, 101.0), (5, '2012-08-26', 'EUR', 101, NULL, 0, 100, 2, NULL), (6, '2012-08-25', 'default2', 101, 0, 100, 100, 99, 0.0), (7, '2023-01-01', NULL, 99, 99, 0, -1, 99, 1.0), (8, '2012-08-25', NULL, 101, 0, 99, NULL, 99, 2.0), (9, '2012-08-26', 'default1', NULL, 99, -1, 101, 1, 2.0), (10, '2012-08-24', 'EUR', -1, -1, NULL, 0, 1, 99.0), (11, '2023-01-01', '2012-08-25', 2, -1, 99, 101, 0, 101.0), (12, '2012-08-24', NULL, 99, 101, 0, NULL, 2, NULL), (13, NULL, NULL, 1, -1, 100, -1, NULL, 101.0), (14, NULL, '2012-08-25', 0, 99, -1, NULL, 101, 99.0), (15, '2023-01-01', NULL, 100, NULL, 2, 1, 99, NULL), (16, NULL, NULL, 1, 99, 2, 99, 99, 101.0), (17, '2023-01-02', 'default2', 1, 0, 2, 99, -1, NULL), (18, '2012-08-24', '2012-08-25', -1, 101, 2, 99, -1, 100.0), (19, '2023-01-01', NULL, 2, NULL, 100, 0, 0, 99.0), (20, NULL, '2012-08-25', 1, 0, 100, 100, 1, 100.0), (21, NULL, 'default1', 0, 101, 0, NULL, -1, 101.0), (22, '2012-08-25', 'default2', 100, 101, NULL, 2, 2, 99.0), (23, '2023-01-01', '2012-08-25', NULL, -1, 101, 2, 1, 1.0), (24, NULL, 'default2', 2, -1, 101, 100, 0, -1.0), (25, '2012-08-25', 'default2', 101, 99, 2, 101, 2, 0.0), (26, '2023-01-02', '2012-08-25', 101, 0, 100, 101, 1, 100.0), (27, NULL, '2012-08-25', 2, 1, 101, 101, 100, 0.0), (28, '2023-01-01', 'default1', 1, -1, 2, 2, 2, 99.0), (29, '2012-08-26', '2012-08-25', 1, 1, 0, -1, 99, NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (2, 'EUR', '2012-08-25'), (0, 'EUR', 'default1'), (99, 'default2', 'EUR'), (1, 'EUR', 'default2'), (100, '2012-08-25', '2012-08-25'), (-1, '2012-08-25', '2012-08-25'), (101, 'default2', 'default1'), (3, 'default2', '2012-08-25'), (4, 'EUR', '2012-08-25'), (5, 'default2', 'default2'), (6, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(16.666666666666668,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN customers.Currency = 'EUR' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(DISTINCT transactions_1k.CustomerID) AS EUR_Percentage FROM transactions_1k INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.Date = '2012-08-25';

/*
Prediction Result:
(25.0,)
*/