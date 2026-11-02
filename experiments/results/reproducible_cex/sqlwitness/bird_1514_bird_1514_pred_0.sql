-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', '2012-08-24', NULL, 0, 1, NULL, NULL, 1.0), (1, '2026-10-27', '2012-08-24', NULL, 0, 1, 0, 1, 1.0), (2, '2012-08-24', '16:25:00', 1, 0, NULL, 0, 1, 0.0), (3, '2026-10-27', '16:25:00', 0, 1, NULL, 1, 0, 1.0), (4, NULL, '2012-08-24', NULL, 1, 1, 0, 0, 1.0), (5, '2026-10-27', '2012-08-24', NULL, 0, 1, 1, 1, 1.0), (6, '2023-01-01', 'default1', 1, 0, 1, NULL, 0, 1.0), (7, '2012-08-24', 'default2', NULL, 0, 0, NULL, NULL, 0.0), (8, '2012-08-25', '2012-08-24', 0, 1, 1, 1, 0, 1.0), (9, '2012-08-23', 'default1', NULL, 0, 0, 0, 0, NULL), (10, '2023-01-02', '2012-08-24', 0, 1, 0, NULL, 1, 1.0), (11, '2012-08-24', 'default2', 1, NULL, 0, 0, NULL, 0.0), (12, '2012-08-24', '2012-08-24', 1, NULL, 1, 1, 0, 0.0), (13, '2026-10-27', 'default1', 0, NULL, 1, 0, 1, 0.0), (14, '2012-08-23', 'default2', NULL, 0, 0, 0, 0, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 1, 'default2', '2012-08-24'), (0, NULL, '16:25:00', '2012-08-24'), (2, 1, 'default2', 'default2'), (3, NULL, 'default1', 'default1'), (4, 0, 'default1', '2012-08-24'), (5, 0, NULL, 'default1'), (6, 1, '16:25:00', 'default1'), (7, 1, 'default1', '2012-08-24'), (8, 0, NULL, '16:25:00'), (9, 0, 'default2', 'default2'), (10, NULL, 'default1', '16:25:00');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default2', '16:25:00'), (1, '16:25:00', 'default2'), (2, '16:25:00', '2012-08-24'), (3, 'default1', '16:25:00'), (4, 'default1', '2012-08-24'), (5, '16:25:00', '2012-08-24'), (6, 'default2', '2012-08-24'), (7, '16:25:00', '16:25:00'), (8, 'default1', '2012-08-24'), (9, 'default1', NULL), (10, NULL, '2012-08-24'), (11, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Currency FROM customers AS T1 INNER JOIN "transactions_1k" AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '2012-08-24' AND T2.Time = '16:25:00';

/*
Prediction Result:
('default2',)
*/