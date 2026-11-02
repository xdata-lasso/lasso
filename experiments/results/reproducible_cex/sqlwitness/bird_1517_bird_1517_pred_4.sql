-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, '2023-01-02', 'default2', 1, 0, 0, NULL, 2, NULL), (1, '2023-01-02', NULL, 2, 0, 2, 1, NULL, NULL), (0, '2023-01-02', 'default1', NULL, 2, NULL, 1, 2, 2.0), (3, '2023-01-01', 'default1', 2, 2, 0, 0, 0, 2.0), (4, '2023-01-01', 'default2', 1, 0, 1, 2, 1, 2.0), (5, NULL, 'default2', NULL, 2, 1, NULL, NULL, 1.0), (6, '2023-01-02', 'default2', 2, 1, 0, NULL, 0, 1.0), (7, '2023-01-02', 'default1', 2, NULL, 1, NULL, 2, 0.0), (8, '2023-01-02', 'default2', 1, 0, 2, 2, 2, 0.0);
INSERT INTO customers (customerid, segment, currency) VALUES (2, NULL, NULL), (0, 'default2', NULL), (1, 'default1', 'default2'), (3, NULL, NULL), (4, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT c.segment FROM customers AS c WHERE c.customerid = (SELECT t.customerid FROM transactions_1k AS t ORDER BY t.date ASC, t.transactionid NULLS LAST LIMIT 1);

/*
Prediction Result:
*/