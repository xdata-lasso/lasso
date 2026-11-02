-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (101, '2023-01-02', NULL, 0, -1, 101, 99, 2, 99.0), (99, NULL, 'EUR', 100, 100, 101, -1, 101, NULL), (1, '2023-01-01', '2012-08-25', 99, NULL, 101, NULL, 100, 99.0), (0, '2012-08-25', '2012-08-25', 101, -1, 100, 2, 2, 2.0), (100, '2012-08-24', '2012-08-25', 0, 1, 101, 0, 1, 99.0), (-1, '2012-08-24', NULL, 100, 2, 100, 101, 1, NULL), (2, '2012-08-26', '2012-08-25', NULL, 0, 100, -1, 0, 2.0), (3, '2012-08-25', 'default2', 101, 1, NULL, 0, NULL, NULL), (4, NULL, '2012-08-25', 1, 99, 101, 1, 101, 100.0), (5, '2012-08-26', 'default1', 100, -1, 99, 0, 101, 101.0);
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'EUR', NULL), (0, NULL, NULL), (100, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(COUNT(DISTINCT t1.customerid) AS REAL) * 100 / (SELECT COUNT(DISTINCT customerid) FROM transactions_1k WHERE date = '2012-08-25') AS percentage FROM transactions_1k AS t1 INNER JOIN customers AS t2 ON t1.customerid = t2.customerid WHERE t1.date = '2012-08-25' AND t2.currency = 'EUR';

/*
Prediction Result:
(0.0,)
*/