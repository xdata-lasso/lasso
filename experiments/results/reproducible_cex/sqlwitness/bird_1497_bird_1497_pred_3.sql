-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (2, '201206%', '201206%'), (1, NULL, '201206%'), (0, 'SME', '201206%'), (3, 'SME', 'default1'), (4, 'default1', 'SME'), (5, '201206', 'SME'), (6, 'SME', '201206'), (7, 'SME', '201206%'), (8, 'default1', NULL), (9, '201206%', 'SME'), (10, 'SME', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (0, '201206%', 1.0), (7, '201206', 1.0), (2, 'default1', 2.0), (7, '201206%', 0.0), (6, 'default2', 1.0), (3, '201206', 2.0), (8, 'SME', NULL), (7, 'default1', 2.0), (2, '201206%', 2.0), (10, 'default1', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201206' AND T1.Segment = 'SME' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT customers.CustomerID FROM customers INNER JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID WHERE yearmonth."Date" LIKE '201206%' AND customers.Segment = 'SME' GROUP BY customers.CustomerID ORDER BY SUM(yearmonth.Consumption) ASC, customers.CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
(0,)
*/