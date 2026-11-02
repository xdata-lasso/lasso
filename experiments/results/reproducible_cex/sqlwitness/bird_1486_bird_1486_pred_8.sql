-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, NULL, 'SME', NULL, NULL, 0, -1, 2, 1.0), (0, NULL, NULL, -1, -1, 1, 0, 1, 2.0), (1, '2023-01-02', 'EUR', 0, -1, 0, 0, 2, 0.0), (-1, '2023-01-01', 'default2', 0, 1, NULL, 1, 0, 0.0), (3, '2023-01-02', 'EUR', 2, NULL, NULL, 1, 0, 2.0), (4, '2023-01-02', 'SME', 0, NULL, 0, NULL, NULL, 2.0), (5, NULL, 'CZK', 1, 0, -1, 0, 2, NULL), (6, '2023-01-01', 'CZK', -1, 0, -1, NULL, NULL, 1.0), (7, '2023-01-01', 'default2', NULL, NULL, 2, 0, -1, 0.0), (8, NULL, 'default2', 2, 1, 2, 1, 2, 2.0);
INSERT INTO customers (customerid, segment, currency) VALUES (2, NULL, 'EUR'), (-1, 'CZK', 'SME'), (0, 'CZK', 'default2'), (1, 'SME', NULL), (3, 'default1', 'CZK'), (4, NULL, 'CZK'), (5, 'SME', 'default2'), (6, 'default1', 'default1'), (7, 'SME', 'EUR'), (8, 'SME', 'default2'), (9, 'SME', 'EUR'), (10, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(-2,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN T1.Currency = 'CZK' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.Currency = 'EUR' THEN 1 ELSE 0 END) FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME';

/*
Prediction Result:
(0,)
*/