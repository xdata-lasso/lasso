-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2012-08-24', NULL, 1, 0, 1, NULL, NULL, 548.4), (0, '2023-01-01', 'default1', 1, 0, 0, 0, NULL, 549.4), (2, NULL, '2012-08-24', NULL, NULL, NULL, 1, 1, 548.4), (3, '2023-01-02', 'default1', 0, 0, NULL, 0, NULL, NULL), (4, '2023-01-02', 'default1', 1, 0, 1, NULL, NULL, 549.4), (5, '2012-08-25', 'default2', 0, 0, NULL, 1, NULL, 549.4), (6, '2023-01-02', 'default1', NULL, NULL, 0, 1, 1, 0.0), (7, '2012-08-24', '2012-08-24', 1, 0, 0, 1, 1, NULL), (8, '2023-01-01', 'default2', 1, 0, NULL, NULL, 1, 548.4), (9, NULL, NULL, 0, 0, 0, 0, 1, 549.4), (10, NULL, 'default2', 0, NULL, 0, 0, 1, NULL), (11, '2023-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL), (12, NULL, 'default2', 0, 1, 1, 1, 0, NULL), (13, '2023-01-02', 'default1', NULL, NULL, 0, 1, 0, 549.4), (14, NULL, NULL, 1, 0, NULL, 0, 0, 548.4), (15, '2012-08-23', NULL, 1, 1, NULL, 0, 1, 549.4);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, 'default1', 'default2'), (0, 0, NULL, 'default1'), (2, 1, 'default2', 'default1'), (3, 0, '2012-08-24', 'default1'), (4, 1, 'default1', 'default2');
INSERT INTO customers (customerid, segment, currency) VALUES (0, '2012-08-24', 'default1'), (1, 'default1', NULL), (2, 'default1', '2012-08-24'), (3, NULL, 'default2'), (4, NULL, '2012-08-24'), (5, 'default1', 'default2'), (6, '2012-08-24', '2012-08-24'), (7, NULL, 'default2'), (8, 'default2', 'default1'), (9, '2012-08-24', '2012-08-24'), (10, 'default2', 'default2'), (11, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT c.Currency FROM transactions_1k AS t INNER JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE t.Date = '2012-08-24' AND t.Amount = 548.4;

/*
Prediction Result:
*/