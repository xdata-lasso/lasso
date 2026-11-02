-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', NULL, 1, 0, NULL, NULL, NULL, 1.0), (1, '2012-08-24', NULL, 1, NULL, 0, 1, NULL, 0.0), (2, '2012-08-24', '%Y-%m-%d', 1, 1, NULL, 1, 0, 0.0), (3, '2023-01-02', 'default1', 0, NULL, NULL, 1, NULL, 549.4), (4, '2012-08-23', NULL, 1, 0, 1, 0, NULL, 1.0), (5, '2012-08-24', NULL, 0, 0, 0, 1, NULL, 548.4);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 1, '%Y-%m-%d', 'default1'), (0, 1, NULL, 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default2', 'default2'), (1, NULL, '2012-08-24'), (2, '%Y-%m-%d', '%Y-%m-%d'), (3, NULL, '2012-08-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT customers.segment FROM customers INNER JOIN transactions_1k ON customers.customerid = transactions_1k.customerid WHERE STRFTIME('%Y-%m-%d', transactions_1k.date) = '2012-08-24' AND transactions_1k.price = 548.4;

/*
Prediction Result:
('default2',)
*/