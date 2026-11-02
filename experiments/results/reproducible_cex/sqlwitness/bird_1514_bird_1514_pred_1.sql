-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', '16:25:00', 1, 1, 0, 1, NULL, 0.0), (1, '2012-08-25', 'default2', 0, NULL, NULL, 1, NULL, 1.0), (2, NULL, NULL, NULL, NULL, 0, 1, 1, 1.0), (3, '2012-08-23', '16:25:00', 0, 1, 1, 1, NULL, 1.0), (4, '2012-08-23', 'default2', 0, 0, 1, NULL, NULL, 1.0), (5, '2012-08-25', '2012-08-24', 1, 0, 0, 1, 1, 1.0), (6, '2026-10-27', '2012-08-24', 0, 1, 1, 0, NULL, NULL), (7, NULL, NULL, 0, 1, NULL, NULL, 1, NULL), (8, NULL, '16:25:00', NULL, NULL, 0, 1, NULL, 1.0), (9, '2023-01-01', '2012-08-24', 1, 1, NULL, NULL, 1, 1.0), (10, '2026-10-27', NULL, NULL, 1, 0, 0, NULL, NULL), (11, '2012-08-24', '16:25:00', 0, 0, 1, NULL, NULL, NULL), (12, '2023-01-02', NULL, 1, NULL, NULL, 0, 1, 1.0), (13, '2026-10-27', NULL, NULL, 1, 0, 1, 0, 0.0), (14, '2012-08-25', '16:25:00', 1, 1, 1, NULL, NULL, 1.0), (15, '2023-01-01', NULL, 1, NULL, 0, 0, 1, NULL), (16, '2012-08-25', 'default1', NULL, NULL, 1, 1, 0, 1.0), (17, '2012-08-24', '16:25:00', 1, 1, NULL, NULL, NULL, NULL), (18, NULL, 'default1', 1, NULL, 0, NULL, 0, 0.0), (19, '2023-01-01', '16:25:00', 0, NULL, 1, NULL, 1, 1.0), (20, '2026-10-27', '2012-08-24', 0, NULL, 1, NULL, 0, 1.0), (21, '2012-08-24', '2012-08-24', 1, NULL, 0, NULL, 1, NULL), (22, '2023-01-01', '16:25:00', 0, 1, 0, 1, 0, NULL), (23, '2026-10-27', '16:25:00', 1, NULL, NULL, 0, NULL, NULL), (24, '2023-01-01', '2012-08-24', 1, 0, NULL, NULL, 0, NULL), (25, '2012-08-25', NULL, 0, NULL, 0, 0, 1, 1.0), (26, NULL, '16:25:00', NULL, 0, 0, NULL, 0, 0.0), (27, NULL, '16:25:00', 0, 1, 1, 0, NULL, 1.0), (28, '2012-08-25', NULL, 0, NULL, 0, 1, 1, 0.0), (29, '2023-01-02', NULL, NULL, NULL, 0, 1, 0, 0.0), (30, '2012-08-24', '16:25:00', 1, 0, 0, 1, 0, NULL), (31, '2026-10-27', 'default1', NULL, NULL, 1, 1, 0, 1.0), (32, '2012-08-23', 'default1', 1, NULL, 1, NULL, NULL, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, '16:25:00', '2012-08-24'), (0, 0, NULL, 'default1'), (2, NULL, NULL, 'default1'), (3, 0, NULL, '16:25:00'), (4, 0, 'default2', '16:25:00'), (5, 1, NULL, '2012-08-24'), (6, 0, 'default1', 'default1'), (7, NULL, '2012-08-24', 'default2'), (8, 1, 'default1', 'default2'), (9, NULL, '2012-08-24', 'default2'), (10, 1, '2012-08-24', '2012-08-24'), (11, 1, NULL, 'default2'), (12, 1, 'default1', 'default2'), (13, 0, 'default2', NULL), (14, 0, 'default1', 'default2'), (15, 0, NULL, 'default1'), (16, 0, 'default1', 'default1'), (17, 0, 'default1', '2012-08-24'), (18, 0, 'default1', NULL), (19, NULL, 'default2', 'default1'), (20, 1, 'default1', '2012-08-24'), (21, 0, '16:25:00', 'default2'), (22, 0, '2012-08-24', 'default1'), (23, 1, '2012-08-24', '2012-08-24'), (24, 0, 'default1', NULL), (25, 0, '2012-08-24', '16:25:00'), (26, 1, '16:25:00', '2012-08-24'), (27, 0, '16:25:00', '16:25:00'), (28, NULL, '2012-08-24', 'default2');
INSERT INTO customers (customerid, segment, currency) VALUES (0, '16:25:00', 'default1'), (1, '16:25:00', '16:25:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
('default1',)
('16:25:00',)
*/

-- Prediction Query
SELECT customers.Currency FROM customers INNER JOIN transactions_1k ON customers.CustomerID = transactions_1k.CustomerID WHERE transactions_1k.Date = '2012-08-24' AND transactions_1k.Time = '16:25:00';

/*
Prediction Result:
('default1',)
('16:25:00',)
('16:25:00',)
*/