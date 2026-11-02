-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (2, 'default1', NULL), (0, '201309', NULL), (1, '201309', 'default1'), (3, 'default2', '201309'), (4, 'default2', 'default1'), (5, 'default2', '201309'), (6, NULL, 'default1'), (7, 'default2', '201309'), (8, 'default1', NULL), (9, NULL, 'default1'), (10, 'default2', 'default1'), (11, NULL, '201309');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (3, '201309', NULL), (2, 'default2', 1.0), (9, 'default1', 0.0), (3, 'default2', 1.0), (4, 'default1', 0.0), (6, '201309', 0.0), (2, 'default1', 2.0), (3, 'default1', 2.0), (9, '201309', NULL), (4, '201309', 0.0), (0, '201309', 0.0), (2, '201309', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT c.segment FROM yearmonth AS y INNER JOIN customers AS c ON y.customerid = c.customerid WHERE y.date = '201309' GROUP BY c.segment ORDER BY SUM(y.consumption) ASC, c.segment NULLS LAST LIMIT 1;

/*
Prediction Result:
('201309',)
*/