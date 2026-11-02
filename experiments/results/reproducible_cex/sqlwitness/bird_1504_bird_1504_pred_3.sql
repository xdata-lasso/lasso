-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, '%Y-%m', 0, 1, 0, 1, NULL, 0.0), (0, '2023-01-02', '2012-01', NULL, 1, 1, NULL, 0, NULL), (2, '2023-01-02', '2012-01', 1, 1, NULL, 0, 1, 1.0), (3, '2012-01-27', 'default1', 1, NULL, 0, 0, 1, 0.0), (4, '2023-01-01', '2012-01', 1, 1, 1, NULL, 1, NULL), (5, '2023-01-01', 'default1', 1, 0, NULL, 1, NULL, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(Amount) FROM transactions_1k WHERE Date LIKE '2012-01%';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(Price) FROM transactions_1k WHERE STRFTIME('%Y-%m', Date) = '2012-01';

/*
Prediction Result:
(0.0,)
*/