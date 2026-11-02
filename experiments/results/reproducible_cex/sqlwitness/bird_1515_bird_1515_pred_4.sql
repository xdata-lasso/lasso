-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2012-08-23', 'default1', 0, NULL, NULL, NULL, 1, 1.0), (0, '2012-08-23', '2012-08-23', 1, 1, NULL, NULL, NULL, 0.0), (2, '2026-10-27', '21:20:00', 0, NULL, 0, 0, 0, NULL), (3, '2026-10-27', 'default2', NULL, 1, 1, 0, NULL, NULL), (4, '2023-01-02', NULL, 0, NULL, 1, 1, NULL, 1.0), (5, '2012-08-22', '2012-08-23', 1, 0, 0, 0, 0, NULL), (6, '2023-01-01', NULL, NULL, 0, 1, 0, 1, 1.0), (7, '2023-01-02', 'default2', 0, 1, 0, 0, 0, 0.0), (8, '2012-08-23', '21:20:00', 1, 1, 0, NULL, 0, NULL), (9, '2026-10-27', 'default2', 1, 0, 1, 1, NULL, NULL), (10, '2023-01-01', 'default2', 0, 1, NULL, 1, 1, 0.0), (11, '2012-08-22', '21:20:00', 1, NULL, 1, 1, 0, NULL), (12, '2012-08-24', 'default1', NULL, 1, NULL, NULL, 0, 0.0), (13, '2012-08-23', '21:20:00', 1, 1, NULL, 0, 0, NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (1, '2012-08-23', '2012-08-23'), (0, 'default1', '2012-08-23'), (2, NULL, '21:20:00'), (3, 'default1', '2012-08-23'), (4, '2012-08-23', 'default1'), (5, '21:20:00', '2012-08-23'), (6, '21:20:00', NULL), (7, '21:20:00', '21:20:00'), (8, '21:20:00', 'default1'), (9, 'default2', '21:20:00'), (10, '21:20:00', 'default1'), (11, '21:20:00', '21:20:00'), (12, 'default2', '21:20:00'), (13, NULL, 'default2'), (14, '2012-08-23', '2012-08-23'), (15, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.date = '2012-08-23' AND T1.time = '21:20:00';

/*
Gold Result:
('2012-08-23',)
('2012-08-23',)
*/

-- Prediction Query
SELECT DISTINCT customers.segment FROM customers INNER JOIN transactions_1k ON customers.customerid = transactions_1k.customerid WHERE transactions_1k.date = '2012-08-23' AND transactions_1k.time = '21:20:00';

/*
Prediction Result:
('2012-08-23',)
*/