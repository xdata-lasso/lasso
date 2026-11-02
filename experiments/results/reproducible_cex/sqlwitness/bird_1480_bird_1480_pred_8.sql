-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, '2013', 'SME'), (6, NULL, 'default2'), (0, NULL, '2013'), (2, 'default2', '2013'), (3, '2013', 'default1'), (4, 'default1', 'default2'), (5, 'SME', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (6, '2013', 4.0), (1, '2013', 3.0), (3, 'default2', NULL), (4, 'SME', 6.0), (5, 'SME', 2.0), (0, '2013', 6.0), (5, '2013', 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 5, 2) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME' GROUP BY SUBSTRING(T2.Date, 5, 2) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 5, 2) NULLS LAST LIMIT 1;

/*
Gold Result:
('',)
*/

-- Prediction Query
SELECT t1.Date FROM yearmonth AS t1 INNER JOIN customers AS t2 ON t1.CustomerID = t2.CustomerID WHERE t2.Segment = 'SME' AND SUBSTRING(t1.Date, 1, 4) = '2013' GROUP BY t1.Date ORDER BY SUM(t1.Consumption) DESC, t1.Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2013',)
*/