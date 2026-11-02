-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-08-25', NULL, NULL, NULL, 1, 0, NULL, 123.05), (1, '2023-01-02', '2012-08-24', NULL, 0, 0, 1, 1, 0.0), (2, '2012-08-23', 'default2', NULL, 1, 1, NULL, NULL, 123.05), (3, '2023-01-02', 'default1', 1, 0, NULL, 0, NULL, NULL), (4, '2001-12-20', '201201%', 1, 0, 0, 0, 1, 123.05), (5, NULL, 'default1', 0, NULL, 1, 0, 1, 1.0), (6, '2012-08-24', '2012-08-24', 1, 1, 1, 0, 0, 125.05), (7, '2023-01-02', '201201', 0, 0, 1, 1, NULL, NULL), (8, '2012-08-25', 'default1', 1, 0, 1, 0, NULL, 125.05), (9, '2001-12-20', '2012-08-24', NULL, NULL, 0, 0, 0, 0.0), (10, '2023-01-01', '201201%', 0, NULL, 0, 0, 0, 125.05), (11, '2001-12-20', '201201', 0, 1, NULL, 1, 1, 0.0), (12, '2012-08-25', 'default2', NULL, 0, 1, 1, 0, 1.0), (13, '2001-12-20', '201201', 1, 1, NULL, 0, 0, 1.0), (14, '2023-01-02', 'default1', 1, 0, 1, NULL, 1, 1.0), (15, '2023-01-01', NULL, 0, 0, NULL, 1, 1, NULL), (16, '2001-12-20', '201201%', 0, NULL, 1, NULL, NULL, 125.05), (17, '2023-01-01', NULL, NULL, 0, 1, NULL, 0, 1.0), (18, '2001-12-20', 'default2', 0, NULL, NULL, NULL, 1, 0.0), (19, NULL, 'default2', NULL, 0, 0, NULL, 1, 0.0), (20, '2001-12-20', '2012-08-24', 0, 1, 0, NULL, NULL, NULL), (21, NULL, 'default2', NULL, 0, NULL, NULL, 0, 0.0), (22, '2012-08-23', 'default2', 1, 0, 0, NULL, NULL, NULL), (23, '2012-08-24', '201201', 0, NULL, NULL, 1, 1, 124.05), (24, '2012-08-23', 'default1', 0, 0, 1, 1, 1, 0.0), (25, NULL, '201201', 1, 1, NULL, 1, NULL, 123.05), (26, '2001-12-20', 'default1', 1, NULL, NULL, NULL, 0, NULL), (27, '2023-01-02', NULL, 1, NULL, 1, NULL, 0, 125.05), (28, NULL, '201201', 0, NULL, NULL, 1, 0, 1.0);
INSERT INTO customers (customerid, segment, currency) VALUES (0, '2012-08-24', '201201%'), (1, '201201', 'default2'), (2, '2012-08-24', '201201'), (3, '201201%', '2012-08-24'), (4, '201201', 'default1'), (5, 'default1', '2012-08-24'), (6, '201201', '2012-08-24'), (7, '201201', '201201%'), (8, '201201%', 'default1'), (9, 'default2', '2012-08-24'), (10, NULL, '201201'), (11, '2012-08-24', 'default2'), (12, '201201%', NULL), (13, '201201', 'default1'), (14, 'default1', '2012-08-24'), (15, NULL, 'default2'), (16, '201201', NULL), (17, 'default2', '201201'), (18, '201201', '201201%'), (19, NULL, '201201%');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (18, 'default2', 0.0), (4, '201201', NULL), (9, '2012-08-24', 124.05), (19, '201201%', 0.0), (7, 'default1', NULL), (0, '2012-08-24', 124.05), (11, 'default2', 125.05), (0, 'default2', NULL), (9, 'default1', 0.0), (14, '201201%', NULL), (8, '2012-08-24', 0.0), (4, 'default2', 0.0), (8, 'default1', 123.05), (10, 'default1', 123.05), (1, 'default1', 0.0), (0, '201201%', NULL), (11, '201201', 124.05), (0, '201201', NULL), (15, '201201', NULL), (3, 'default1', 124.05);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID, T2.Date, T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Price = 124.05 AND T2.Date = '201201';

/*
Gold Result:
(0, '201201', None)
*/

-- Prediction Query
SELECT T1.Price, T2.Date, T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Price = 124.05 AND T2.Date LIKE '201201%';

/*
Prediction Result:
(124.05, '201201', None)
(124.05, '201201%', None)
*/