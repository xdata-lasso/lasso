-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-08-23', NULL, 0, 0, 0, 0, 1, 549.4), (1, '2012-08-25', 'default1', 0, 0, 0, 1, NULL, 549.4), (2, '2012-08-25', 'default1', 1, 1, 1, NULL, NULL, 547.4), (3, '2023-01-02', 'default2', NULL, 1, 1, 0, NULL, 549.4), (4, NULL, NULL, NULL, 0, 1, NULL, 1, 0.0), (5, '2012-08-23', NULL, 0, 1, 1, 0, 1, 548.4), (6, '2012-08-24', NULL, 0, 0, 0, 1, NULL, 549.4), (7, '2012-08-24', NULL, NULL, 0, 0, 0, NULL, 548.4), (8, '2023-01-02', 'default1', 1, NULL, 0, NULL, NULL, 547.4);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 0, NULL, NULL), (0, 0, 'default2', '2012-08-24'), (2, NULL, NULL, 'default1'), (3, 1, 'default2', 'default1'), (4, NULL, '2012-08-24', 'default1'), (5, 0, NULL, '2012-08-24'), (6, 1, 'default2', 'default2'), (7, 0, 'default2', NULL), (8, 1, 'default2', 'default1'), (9, 0, NULL, 'default2'), (10, 1, NULL, 'default1'), (11, NULL, 'default1', '2012-08-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T1.Country FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Date = '2012-08-24' AND T2.Amount = 548.4;

/*
Prediction Result:
*/