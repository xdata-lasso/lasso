-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-01', 'default1', NULL, 0, 1, 0, 0, 2.0), (0, '2023-01-01', 'default1', NULL, 0, 0, 1, NULL, 2.0), (2, '2023-01-01', NULL, 1, NULL, 1, 0, 1, 2.0), (3, '2023-01-01', NULL, 1, 1, 0, NULL, 0, 2.0), (4, NULL, 'default1', 1, 0, NULL, 1, NULL, 1.0);
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default2', NULL), (1, 'default1', NULL), (2, NULL, 'default1'), (3, 'default1', 'default1'), (4, 'default2', NULL), (5, 'default1', 'default2'), (6, NULL, 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (2, 'default2', 2.0), (0, 'default1', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Price / T2.Amount), T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.CustomerID = (SELECT CustomerID FROM yearmonth ORDER BY Consumption DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1) GROUP BY T2.CustomerID, T1.Currency;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.CustomerID, T1.Currency, AVG(T2.Price) FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID GROUP BY T1.CustomerID ORDER BY SUM(T2.Price) DESC, T1.CustomerID NULLS LAST, T1.Currency NULLS LAST, AVG(T2.Price) NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, None, 1.6666666666666667)
*/