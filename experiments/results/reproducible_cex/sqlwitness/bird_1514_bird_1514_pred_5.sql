-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', 'default1', 1, 0, 0, 1, 1, 0.0), (1, NULL, 'default2', 0, NULL, 1, NULL, 0, NULL), (2, '2012-08-24', NULL, NULL, 1, 0, NULL, NULL, 0.0), (3, '2023-01-02', 'SME', 0, 0, NULL, 1, 0, 0.0), (4, '2012-08-24', '16:25:00', 0, 0, 0, NULL, 0, 0.0), (5, '2012-08-24', '16:25:00', 1, NULL, 0, NULL, 1, NULL), (6, '2012-08-25', NULL, 1, NULL, 1, 1, NULL, 1.0), (7, '2023-01-01', NULL, 1, NULL, 1, NULL, 0, NULL), (8, '2026-10-27', 'SME', 1, 1, 1, 0, NULL, NULL), (9, '2012-08-23', '2012-08-24', 1, 1, NULL, 0, 1, 1.0), (10, NULL, NULL, 0, NULL, 0, 0, 1, NULL), (11, '2012-08-23', '2012-08-24', NULL, NULL, 1, 0, 1, 0.0), (12, '2023-01-01', 'default1', 1, 0, 0, 0, 1, 1.0), (13, '2023-01-02', 'SME', 1, NULL, 0, 1, 1, 0.0), (14, '2012-08-23', '2012-08-24', 1, NULL, 0, 1, 0, 0.0), (15, '2026-10-27', NULL, NULL, 1, 1, 0, NULL, 1.0), (16, '2023-01-01', '2012-08-24', 1, 0, NULL, 1, 0, 0.0), (17, '2026-10-27', NULL, 0, 0, 0, 0, 0, 1.0), (18, '2012-08-23', 'default1', NULL, 1, 1, 0, NULL, NULL), (19, '2012-08-24', 'default1', 1, 1, NULL, 0, NULL, NULL), (20, '2026-10-27', '16:25:00', 1, 0, 0, 0, 0, NULL), (21, '2012-08-25', 'default2', 1, 1, NULL, 1, 0, 1.0), (22, '2023-01-02', '16:25:00', NULL, 1, NULL, 0, NULL, NULL), (23, '2012-08-23', 'default1', NULL, NULL, NULL, 1, 1, NULL), (24, '2012-08-25', '2012-08-24', 0, NULL, 0, 0, NULL, 0.0), (25, '2023-01-02', 'default1', 0, NULL, 1, NULL, 1, 0.0), (26, '2023-01-02', NULL, 0, 0, 1, 1, 1, 0.0), (27, '2023-01-01', 'default1', 1, 0, NULL, 0, 1, 1.0), (28, '2023-01-02', '2012-08-24', NULL, 1, 0, 0, 1, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, 'SME', '2012-08-24'), (0, 0, '16:25:00', 'default1'), (2, 1, 'SME', '16:25:00'), (3, NULL, 'default2', 'SME'), (4, NULL, NULL, '16:25:00'), (5, 1, 'SME', 'SME'), (6, 0, 'default2', '2012-08-24'), (7, NULL, NULL, '16:25:00'), (8, 1, 'default1', '16:25:00'), (9, NULL, 'default2', 'default1'), (10, NULL, '16:25:00', '16:25:00'), (11, 1, '16:25:00', 'default1'), (12, 1, NULL, 'default1'), (13, NULL, '2012-08-24', 'default1'), (14, 1, NULL, 'default1'), (15, 1, '16:25:00', 'default1'), (16, 0, NULL, NULL), (17, 0, 'default1', 'SME'), (18, NULL, '2012-08-24', 'default2'), (19, NULL, '2012-08-24', NULL), (20, 1, NULL, 'default2'), (21, 0, NULL, 'default2'), (22, 1, '16:25:00', 'default2'), (23, 0, '16:25:00', 'SME'), (24, NULL, 'SME', '16:25:00'), (25, NULL, 'default1', 'default1'), (26, 1, '16:25:00', '16:25:00'), (27, NULL, 'default1', '2012-08-24');
INSERT INTO customers (customerid, segment, currency) VALUES (1, '2012-08-24', 'default1'), (0, 'SME', '16:25:00'), (2, 'default1', '16:25:00'), (3, 'default2', NULL), (4, 'default2', '16:25:00'), (5, 'default1', NULL), (6, 'default1', 'SME'), (7, '16:25:00', 'default2'), (8, 'SME', NULL), (9, 'default2', NULL), (10, 'default2', '16:25:00'), (11, 'SME', '2012-08-24'), (12, NULL, 'default1'), (13, '2012-08-24', '16:25:00'), (14, '16:25:00', 'default2'), (15, 'default1', '16:25:00'), (16, NULL, 'default2'), (17, 'SME', 'default2'), (18, '16:25:00', '16:25:00'), (19, 'default1', 'default1'), (20, NULL, NULL), (21, 'SME', '2012-08-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
('16:25:00',)
('default1',)
*/

-- Prediction Query
SELECT customers.Currency FROM transactions_1k INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.Date = '2012-08-24' AND transactions_1k."Time" = '16:25:00' AND customers.Segment = 'SME';

/*
Prediction Result:
('16:25:00',)
*/