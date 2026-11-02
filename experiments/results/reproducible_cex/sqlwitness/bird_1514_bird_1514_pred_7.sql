-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2012-08-24', 'default1', 0, 1, 1, 0, 0, 0.0), (0, '2026-10-27', '2012-08-24', NULL, 0, NULL, NULL, NULL, NULL), (2, '2023-01-02', '2012-08-24', NULL, 1, 1, NULL, 0, 0.0), (3, '2012-08-23', 'default2', 1, 1, NULL, NULL, 1, 1.0), (4, '2023-01-01', 'default2', NULL, NULL, NULL, 0, 1, NULL), (5, '2012-08-23', 'default2', 1, 1, 0, NULL, 1, 1.0), (6, '2026-10-27', 'default2', NULL, NULL, NULL, 1, 0, 0.0), (7, '2023-01-01', 'default1', NULL, 1, NULL, 0, 0, NULL), (8, NULL, 'default2', 0, NULL, NULL, 1, 0, 1.0), (9, '2012-08-24', 'default1', NULL, 0, 1, 1, 0, 0.0), (10, '2026-10-27', '16:25:00', 1, NULL, NULL, 1, 1, 0.0), (11, '2012-08-24', '16:25:00', 0, NULL, 1, 0, NULL, 1.0), (12, '2012-08-23', 'default2', 0, NULL, 1, NULL, 1, NULL), (13, '2012-08-25', NULL, 1, NULL, NULL, NULL, 1, 0.0), (14, '2023-01-02', NULL, 0, NULL, 1, NULL, 1, 1.0), (15, '2012-08-23', '16:25:00', 0, NULL, NULL, 1, NULL, NULL), (16, '2012-08-25', 'default2', 0, 0, NULL, NULL, 0, NULL), (17, '2012-08-25', '16:25:00', NULL, 1, 0, NULL, 0, NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (1, NULL, '2012-08-24'), (0, NULL, 'default2'), (2, '16:25:00', '16:25:00'), (3, '16:25:00', '16:25:00'), (4, '16:25:00', NULL), (5, 'default1', 'default2'), (6, 'default2', 'default1'), (7, '2012-08-24', 'default1'), (8, 'default2', NULL), (9, 'default1', '16:25:00'), (10, '16:25:00', '2012-08-24'), (11, NULL, '16:25:00'), (12, 'default2', NULL), (13, '2012-08-24', NULL), (14, '2012-08-24', 'default1'), (15, '16:25:00', '2012-08-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Currency FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1."Date" = '2012-08-24' AND T1."Time" = '16:25:00';

/*
Prediction Result:
('default2',)
*/