-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2001-12-20', NULL, 38507, NULL, 38508, -1, 1, 38509.0), (38509, NULL, 'default1', 38507, 38507, 38507, 0, 38509, 0.0), (38507, '2001-12-20', 'default1', NULL, 38508, 0, 1, 0, 38508.0), (-1, NULL, 'default1', 0, 38508, 1, 0, 38509, 38508.0), (0, '2001-12-20', NULL, -1, 38507, 1, 38508, 38509, 38507.0), (38508, NULL, '201201', 38508, 38508, 38508, 0, 38508, 38509.0), (2, NULL, NULL, 0, 1, 38507, 38507, NULL, -1.0), (3, '2023-01-02', NULL, 38508, 38509, -1, 38507, NULL, 1.0), (4, NULL, 'default2', 38509, 38507, -1, NULL, 0, NULL), (5, '2023-01-01', 'default2', NULL, 38508, -1, NULL, 38508, 38508.0), (6, '2023-01-01', '201201', -1, 38508, NULL, 38508, NULL, 38509.0), (7, '2023-01-01', 'default1', -1, 1, 38509, 38507, 38509, 38509.0), (8, '2023-01-02', '201201', 1, 38508, 38508, -1, 38509, 1.0), (9, '2001-12-20', '38508', 38507, NULL, 38509, -1, NULL, 38508.0), (10, '2023-01-02', '201201', 1, -1, 38509, 38508, 38508, NULL), (11, '2001-12-20', '201201', 38508, 38509, NULL, 38509, 1, 1.0), (12, '2023-01-02', NULL, 38508, 0, 38507, 38509, 38508, NULL), (13, '2023-01-01', 'default1', 38507, 38508, 0, 38508, 38509, 1.0), (14, '2023-01-02', NULL, -1, 0, NULL, 38508, 0, 38509.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (38507, 38508, NULL, '38508'), (38508, 38509, NULL, '201201'), (1, 38508, 'default1', '38508'), (38509, 0, 'default1', 'default2'), (0, 0, '201201', 'default2'), (-1, -1, 'default1', NULL), (2, 38507, 'default2', '38508'), (3, NULL, 'default2', 'default1'), (4, 0, 'default1', '38508'), (5, 38509, '38508', 'default1'), (6, 38508, 'default1', '38508'), (7, 1, '38508', NULL), (8, 1, '201201', NULL), (9, 38508, NULL, 'default2'), (10, NULL, '201201', 'default1'), (11, -1, '201201', 'default1'), (12, 1, '38508', 'default1'), (13, 38509, '38508', '38508');
INSERT INTO customers (customerid, segment, currency) VALUES (38507, '201201', 'default1'), (-1, 'default1', NULL), (1, NULL, '201201'), (38509, 'default2', NULL), (0, '201201', 'default2'), (38508, 'default2', '201201'), (2, '38508', '201201'), (3, 'default2', 'default2'), (4, 'default1', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (3, '201201', 38508.0), (1, '38508', 0.0), (38508, '201201', 38507.0), (-1, 'default1', -1.0), (38507, 'default1', -1.0), (0, '38508', 38507.0), (2, 'default2', 38508.0), (38508, '38508', NULL), (4, 'default1', 38509.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Price), SUM(IIF(T3.Date = '201201', T1.Price, 0)) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.CustomerID = '38508';

/*
Gold Result:
(77020.0, 38510.0)
*/

-- Prediction Query
SELECT SUM(T1.Amount), T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.CustomerID = 38508 AND T2.Date = '201201';

/*
Prediction Result:
(77017, 38507.0)
*/