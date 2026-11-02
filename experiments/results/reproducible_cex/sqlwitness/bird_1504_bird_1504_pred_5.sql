-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-02', '2012-01', 1, NULL, NULL, 0, NULL, 0.0), (0, '2012-01-27', '2012-01%', 1, NULL, NULL, 1, NULL, 0.0), (2, '2012-01-27', NULL, 1, 0, NULL, NULL, NULL, 1.0), (3, '2023-01-01', 'default2', 1, NULL, 0, 0, 1, 1.0), (4, '2012-01-27', '%Y-%m', 1, 0, NULL, 0, 1, 1.0), (5, '2023-01-01', NULL, 0, 1, NULL, NULL, NULL, NULL), (6, '2023-01-02', '2012-01', 0, 1, 1, NULL, 1, 0.0), (7, NULL, '2012-01%', 0, 0, 1, NULL, NULL, 0.0), (8, '2023-01-01', '2012-01', 1, 0, 0, 1, 0, NULL), (9, '2023-01-01', 'default2', 0, 0, 0, 0, NULL, 1.0), (10, '2023-01-01', '2012-01', NULL, 1, 0, 1, NULL, NULL), (11, '2023-01-02', '2012-01', NULL, 1, 1, NULL, NULL, 1.0), (12, '2012-01-27', '%Y-%m', NULL, NULL, 0, 0, NULL, 1.0), (13, NULL, '%Y-%m', 1, 0, 1, NULL, NULL, NULL), (14, '2012-01-27', 'default2', 1, NULL, 0, 1, 1, 0.0), (15, '2023-01-02', '%Y-%m', 1, NULL, NULL, NULL, NULL, 1.0), (16, NULL, NULL, 0, 1, NULL, 1, NULL, 0.0), (17, '2012-01-27', '%Y-%m', NULL, 0, 0, 0, NULL, 0.0), (18, '2012-01-27', NULL, 1, NULL, NULL, 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(Amount) FROM transactions_1k WHERE Date LIKE '2012-01%';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(amount * price) AS averagetotalprice FROM transactions_1k WHERE STRFTIME('%Y-%m', "transactions_1k"."Date") = '2012-01';

/*
Prediction Result:
(0.5,)
*/