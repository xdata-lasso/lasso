-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-08-26', NULL, 2, 1, 1, NULL, 0, NULL), (1, '2012-08-24', 'default2', 2, 0, 2, 2, 1, 1.0), (2, NULL, '2012-08-25', NULL, 1, 2, 0, 2, 2.0), (3, '2023-01-02', 'default1', 2, 2, 1, 1, 2, 1.0), (4, '2023-01-01', 'default1', NULL, NULL, 0, 1, NULL, 1.0), (5, '2012-08-26', 'default1', 0, 1, 1, 1, 2, 1.0), (6, NULL, 'default2', 0, 1, 0, 1, 0, 1.0), (7, NULL, 'default2', NULL, 2, NULL, NULL, 1, 1.0), (8, '2012-08-25', NULL, NULL, 2, 2, 0, 1, 2.0), (9, '2012-08-24', '2012-08-25', 1, 0, 2, 0, 2, 1.0), (10, '2012-08-25', '2012-08-25', NULL, 2, NULL, 1, 2, 2.0), (11, NULL, '2012-08-25', 0, 0, NULL, 0, 2, 0.0), (12, '2012-08-24', 'default1', 1, 1, 2, 2, NULL, 2.0), (13, '2012-08-25', '2012-08-25', 0, 2, 1, 2, NULL, NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default2', '2012-08-25'), (0, '2012-08-25', 'default1'), (2, '2012-08-25', NULL), (3, NULL, '2012-08-25'), (4, '2012-08-25', '2012-08-25'), (5, '2012-08-25', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-25' GROUP BY CustomerID ORDER BY SUM(Price) DESC, CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2."Date" = '2012-08-25' ORDER BY T2.Amount DESC, T1.customerid NULLS LAST, T2.transactionid NULLS LAST LIMIT 1;

/*
Prediction Result:
(0,)
*/