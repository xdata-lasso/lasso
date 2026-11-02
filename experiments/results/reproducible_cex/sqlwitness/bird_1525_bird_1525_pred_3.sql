-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (101, '2023-01-02', 'EUR', 2, 99, 101, 101, 100, 0.0), (1, '2012-08-26', 'EUR', NULL, 2, 1, 1, 2, 101.0), (0, '2023-01-01', 'default2', 101, 0, 2, 1, 1, NULL), (-1, NULL, '2012-08-25', 0, 2, 101, 0, 99, 0.0), (2, NULL, 'EUR', -1, 2, 99, 0, 2, 101.0);
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default2', '2012-08-25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT t.CustomerID) AS REAL) * 100.0 / CAST((SELECT COUNT(DISTINCT CustomerID) FROM customers) AS REAL)) AS percentage FROM transactions_1k AS t JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'EUR' AND t.Date = '2012-08-25';

/*
Prediction Result:
(0.0,)
*/