-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-02', '%H', NULL, NULL, NULL, 0, 0, NULL), (0, NULL, 'CZK', NULL, 0, 0, 1, 1, 0.0), (2, '2026-10-27', 'default2', 1, NULL, 0, 0, 1, 0.0), (3, '2012-08-25', '13', 0, 0, 0, 0, 0, 1.0), (4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0), (5, '2012-08-25', 'default1', NULL, 0, 0, 1, 1, 1.0), (6, '2023-01-01', 'CZK', NULL, 1, 0, 1, 1, NULL), (7, '2023-01-02', 'default2', 1, NULL, 0, 1, 1, NULL), (8, '2023-01-02', 'EUR', 1, NULL, 0, 0, 0, NULL), (9, '2023-01-02', NULL, 0, 1, NULL, 0, NULL, 1.0), (10, '2026-10-27', '%H', 0, 0, 0, 0, 0, NULL), (11, '2023-01-01', '%H', NULL, 0, 0, 0, NULL, 1.0), (12, '2026-10-13', 'default2', 0, NULL, 1, 0, NULL, NULL), (13, '2012-08-27', NULL, 1, NULL, 0, 0, 0, NULL), (14, '2012-08-26', 'CZK', 1, NULL, NULL, 1, NULL, 0.0), (15, '2012-08-26', 'CZK', 0, NULL, 0, 0, 1, NULL), (16, '2012-08-27', '13', NULL, 0, NULL, 0, 1, 0.0), (17, '2026-10-27', '13:00:00', NULL, 1, NULL, 1, 1, 1.0), (18, '2012-08-27', '2012-08-26', 0, 0, 0, 0, NULL, NULL), (19, '2012-08-26', '13', 0, 1, 1, 1, 1, NULL), (20, '2012-08-26', NULL, NULL, 1, NULL, 1, NULL, NULL), (21, NULL, 'default2', NULL, 0, 1, 1, 0, NULL), (22, '2012-08-27', NULL, 1, 0, NULL, NULL, 0, NULL), (23, '2012-08-27', 'default1', 0, 1, 0, 1, 1, NULL), (24, '2023-01-02', 'default1', NULL, NULL, 0, 1, NULL, NULL), (25, '2023-01-02', 'default2', 0, 1, 0, 0, 0, 0.0), (26, '2026-10-13', '2012-08-26', 1, NULL, NULL, 1, NULL, NULL), (27, '2026-10-13', '%H', NULL, 1, 0, 1, NULL, 0.0), (28, NULL, '13:00:00', 1, 0, 1, 1, 1, 1.0), (29, '2012-08-27', '13', NULL, NULL, 0, 0, 1, 1.0), (30, '2023-01-01', 'default2', 0, NULL, 1, 0, NULL, NULL), (31, NULL, 'default1', NULL, 1, NULL, NULL, 1, 0.0), (32, '2023-01-01', 'CZK', 1, 1, 0, NULL, NULL, 0.0);
INSERT INTO customers (customerid, segment, currency) VALUES (1, '2012-08-26', 'default1'), (0, 'default2', 'CZK'), (2, '%H', NULL), (3, 'default2', 'EUR'), (4, 'default1', NULL), (5, '13:00:00', 'CZK'), (6, '%H', '2012-08-26'), (7, '13:00:00', '13'), (8, 'default1', 'default1'), (9, '%H', '%H'), (10, '13', '13:00:00'), (11, '13', 'CZK'), (12, 'default2', 'default2'), (13, NULL, 'CZK'), (14, '%H', '13'), (15, '13', '%H'), (16, 'CZK', 'CZK'), (17, 'default2', 'default2'), (18, 'EUR', 'default1'), (19, '13', 'default1'), (20, 'EUR', '13'), (21, '2012-08-26', 'CZK'), (22, '%H', 'CZK'), (23, 'default2', 'default2'), (24, 'EUR', '%H'), (25, 'EUR', NULL), (26, '13:00:00', NULL), (27, NULL, '13'), (28, 'EUR', '13'), (29, '2012-08-26', 'EUR'), (30, '13', '13:00:00'), (31, '13', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-26' AND T1.Time < '13:00:00' AND T2.Currency = 'EUR';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(transactions_1k.transactionid) FROM transactions_1k INNER JOIN customers ON transactions_1k.customerid = customers.customerid WHERE transactions_1k.date = '2012-08-26' AND STRFTIME('%H', transactions_1k.time) < '13' AND customers.currency = 'CZK';

/*
Prediction Result:
(1,)
*/