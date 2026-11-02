-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', 'default1', 2, 2, 1, 1, 1, NULL), (1, '2023-01-01', 'default2', 0, 2, NULL, 2, 0, 0.0), (2, '2012-08-26', 'default2', 2, NULL, NULL, NULL, NULL, 0.0), (3, NULL, '2012-08-25', NULL, 0, 1, NULL, 0, 0.0), (4, '2012-08-24', 'default2', NULL, 1, NULL, 0, 1, 0.0), (5, '2012-08-25', 'default1', NULL, 0, 2, 1, 1, 1.0), (6, NULL, 'default1', NULL, 0, NULL, 2, 0, 1.0);
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-25' GROUP BY CustomerID ORDER BY SUM(Price) DESC, CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25' GROUP BY T1.CustomerID ORDER BY SUM(T1.Amount * T1.Price) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
*/