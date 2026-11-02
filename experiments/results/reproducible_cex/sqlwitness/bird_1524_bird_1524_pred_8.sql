-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', 'default1', NULL, NULL, NULL, NULL, 0, 1.0), (1, NULL, 'default1', 1, 1, 0, 1, NULL, 547.4), (2, '2012-08-24', 'default1', 0, 1, 1, 0, 0, 0.0), (3, '2012-08-25', '2012-08-24', NULL, 1, NULL, NULL, 1, 0.0), (4, '2012-08-25', 'default1', 1, NULL, 1, NULL, 0, 1.0), (5, '2023-01-02', '2012-08-24', 0, 1, 0, 0, 0, 549.4), (6, '2012-08-24', '2012-08-24', NULL, NULL, 0, 0, 0, 548.4), (7, '2012-08-25', '2012-08-24', 1, 0, 0, 0, NULL, 549.4), (8, '2012-08-24', 'default1', 1, 1, NULL, 1, 1, 547.4), (9, '2023-01-02', 'default1', 1, 0, NULL, 0, 1, 548.4);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, NULL, 'default2'), (0, 1, '2012-08-24', NULL), (2, NULL, NULL, 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default2', '2012-08-24'), (1, NULL, '2012-08-24'), (2, '2012-08-24', 'default2'), (3, '2012-08-24', '2012-08-24'), (4, 'default1', 'default1'), (5, NULL, '2012-08-24'), (6, NULL, '2012-08-24'), (7, 'default1', 'default1'), (8, 'default2', '2012-08-24'), (9, 'default1', 'default1'), (10, '2012-08-24', NULL), (11, NULL, 'default1'), (12, 'default2', '2012-08-24'), (13, NULL, 'default2'), (14, 'default2', NULL), (15, 'default2', 'default2'), (16, 'default2', '2012-08-24'), (17, 'default1', NULL), (18, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
('2012-08-24',)
*/

-- Prediction Query
SELECT T2.Currency FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Prediction Result:
*/