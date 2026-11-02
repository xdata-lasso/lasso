-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (2, 'default1', 'default1'), (0, 'default2', 'default1'), (1, '201309', 'default2'), (3, 'default2', '201309'), (4, '201309', NULL), (5, NULL, NULL), (6, '201309', 'default1'), (7, '201309', NULL), (8, 'default1', 'default2'), (9, NULL, '201309'), (10, 'default1', 'default1'), (11, NULL, 'default2'), (12, 'default1', 'default2'), (13, '201309', '201309'), (14, 'default2', '201309'), (15, '201309', '201309');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, '201309', 2.0), (8, '201309', 1.0), (12, 'default1', 2.0), (7, 'default2', 0.0), (12, '201309', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT Segment FROM customers JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID WHERE yearmonth.Date = '201309' GROUP BY Segment ORDER BY CAST(SUM(yearmonth.Consumption) AS REAL) ASC, Segment NULLS LAST LIMIT 1;

/*
Prediction Result:
('201309',)
*/