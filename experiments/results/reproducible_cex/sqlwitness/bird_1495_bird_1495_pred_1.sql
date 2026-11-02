-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, '2023-01-02', '201309%', 0, 2, NULL, NULL, 2, 1.0), (1, '2023-01-01', '201309', 1, 0, 0, 0, NULL, 1.0), (0, '2023-01-02', 'default1', 1, 0, NULL, 0, NULL, 2.0);
INSERT INTO customers (customerid, segment, currency) VALUES (0, '201309%', 'default1'), (1, 'default2', NULL), (2, '201309', '201309'), (3, '201309', NULL), (4, 'default2', NULL), (5, 'default1', 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, 'default2', NULL), (0, '201309%', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT y.CustomerID FROM yearmonth AS y INNER JOIN transactions_1k AS t ON y.CustomerID = t.CustomerID WHERE y."Date" LIKE '201309%' GROUP BY y.CustomerID ORDER BY SUM(t.Amount) DESC, y.CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
(0,)
*/