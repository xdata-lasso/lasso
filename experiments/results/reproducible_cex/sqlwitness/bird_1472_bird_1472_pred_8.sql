-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'LAM', '2012%'), (201200, '2012%', 'LAM'), (201212, 'default1', 'LAM'), (2, 'default1', '2012%'), (201211, 'LAM', NULL), (201213, NULL, NULL), (0, '2012%', 'default1'), (201201, 'default2', '2012%'), (201202, 'default2', '2012%'), (3, '2012%', '2012%'), (4, 'default2', 'LAM'), (5, 'default1', 'default1'), (6, 'default2', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, 'LAM', 1.0), (3, 'default2', 0.0), (1, 'default2', 2.0), (201201, 'default2', 201202.0), (5, 'default1', 1.0), (5, '2012%', 201213.0), (1, '2012%', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.date BETWEEN 201201 AND 201212 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.CustomerID FROM customers AS c JOIN yearmonth AS y ON c.CustomerID = y.CustomerID WHERE c.Segment = 'LAM' AND y.Date LIKE '2012%' ORDER BY y.Consumption ASC, c.customerid NULLS LAST, y.date NULLS LAST, y.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/