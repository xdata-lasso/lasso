-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, NULL, 'default2', NULL, NULL, 0, NULL, NULL, 1.0), (1, NULL, NULL, 0, NULL, 1, 0, NULL, 1.0), (2, NULL, '%Y%m', 1, 1, 1, 1, 0, 1.0), (3, '2023-01-01', '201306', NULL, NULL, NULL, 0, 0, 1.0), (4, NULL, 'default1', NULL, NULL, NULL, 1, 1, NULL), (5, NULL, NULL, 1, 1, NULL, 1, 1, 0.0), (6, '2023-01-01', '%Y%m', NULL, 1, 1, NULL, 1, 1.0), (7, NULL, NULL, 0, 0, 0, 1, NULL, 1.0), (8, NULL, 'default1', NULL, 1, NULL, 0, NULL, 1.0), (9, '2023-01-02', 'default1', 1, 1, 1, 0, NULL, 1.0), (10, NULL, 'default1', 0, NULL, NULL, 0, 1, NULL), (11, '2023-01-01', '%Y%m', 1, NULL, NULL, 0, 1, NULL), (12, '2023-01-02', NULL, 1, 1, 0, 0, 1, 1.0), (13, NULL, '201306', NULL, 1, NULL, NULL, 0, 1.0), (14, '2023-01-01', 'default1', NULL, 1, 0, NULL, NULL, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, NULL, '%Y%m');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default1', NULL), (1, 'default1', 'default1'), (2, '%Y%m', 'default2'), (3, 'default1', '%Y%m'), (4, NULL, '201306'), (5, 'default1', '%Y%m'), (6, 'default2', NULL), (7, '%Y%m', 'default2'), (8, 'default2', '201306'), (9, 'default2', '201306'), (10, 'default1', 'default1'), (11, NULL, NULL), (12, NULL, '201306'), (13, NULL, '%Y%m');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (8, 'default2', NULL), (0, '201306', 1.0), (11, 'default1', 1.0), (5, 'default2', 0.0), (10, '%Y%m', 1.0), (12, 'default1', 1.0), (6, 'default2', 1.0), (1, 'default2', 1.0), (2, '201306', 1.0), (5, '201306', 0.0), (5, 'default1', 1.0), (9, 'default2', 1.0), (1, '201306', 1.0), (0, '%Y%m', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
(None,)
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE STRFTIME('%Y%m', T1.Date) = '201306';

/*
Prediction Result:
*/