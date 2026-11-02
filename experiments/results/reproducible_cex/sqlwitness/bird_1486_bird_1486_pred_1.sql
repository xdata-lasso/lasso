-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', NULL, -1, NULL, -1, 1, 0, 1.0), (-1, NULL, NULL, 1, NULL, 1, NULL, -1, 0.0), (1, '2023-01-02', 'EUR', NULL, 1, NULL, 0, 1, NULL), (2, '2023-01-02', 'CZK', 1, 1, NULL, 0, NULL, 0.0), (3, '2023-01-02', 'default1', 1, 0, -1, NULL, NULL, 1.0), (4, NULL, NULL, 1, 1, -1, 1, 0, 1.0);
INSERT INTO customers (customerid, segment, currency) VALUES (-1, 'EUR', NULL), (1, 'EUR', NULL), (0, 'SME', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Currency = 'CZK') - SUM(Currency = 'EUR') FROM customers WHERE Segment = 'SME';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN c.Currency = 'CZK' THEN t.Amount ELSE 0 END) - SUM(CASE WHEN c.Currency = 'EUR' THEN t.Amount ELSE 0 END) AS AmountDifference FROM customers AS c INNER JOIN transactions_1k AS t ON c.CustomerID = t.CustomerID WHERE c.Segment = 'SME';

/*
Prediction Result:
(None,)
*/