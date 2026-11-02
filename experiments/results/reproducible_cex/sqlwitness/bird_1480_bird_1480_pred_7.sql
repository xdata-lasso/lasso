-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (3, 'default2', 'default2'), (0, '201301', 'default2'), (2, NULL, '201312'), (6, 'SME', '201301'), (1, '2013', NULL), (5, '201312', '2013'), (4, 'default1', NULL), (7, '201312', '201301'), (8, '201301', '201312'), (9, 'default2', '201301'), (10, NULL, NULL), (11, '201312', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (0, '2013', 1.0), (0, '201312', 1.0), (11, 'default2', NULL), (7, '201301', 4.0), (3, 'default2', 6.0), (1, 'SME', 3.0), (6, '2013', 4.0), (7, '2013', 1.0), (6, '201301', 3.0), (10, 'default1', 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 5, 2) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME' GROUP BY SUBSTRING(T2.Date, 5, 2) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 5, 2) NULLS LAST LIMIT 1;

/*
Gold Result:
('',)
*/

-- Prediction Query
SELECT SUBSTRING(yearmonth.date, 5, 2) AS month, SUM(yearmonth.consumption) AS total_consumption FROM customers INNER JOIN yearmonth ON customers.customerid = yearmonth.customerid WHERE yearmonth.date BETWEEN '201301' AND '201312' AND customers.segment = 'SME' GROUP BY month ORDER BY total_consumption DESC, month NULLS LAST LIMIT 1;

/*
Prediction Result:
('01', 3.0)
*/