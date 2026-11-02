-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (0, '2012', '2012'), (2, 'default1', '201212'), (4, '201212', NULL), (30000, 'KAM', 'default1'), (29999, 'KAM', '201212'), (30001, '201212', '201201'), (5, 'KAM', 'default2'), (1, '2012', '%Y%m'), (3, '2012', '%Y%m'), (6, 'default1', '%Y%m'), (7, '201212', '2012');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (3, '2012', NULL), (2, '201212', 29999.0), (29999, '201201', NULL), (7, '201201', 30001.0), (1, '2012', 4.0), (2, 'default1', 30001.0), (5, '201201', 29999.0), (3, 'default1', 4.0), (30000, 'default1', NULL), (4, '2012', 1.0), (0, '%Y%m', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT yearmonth.customerid) FROM yearmonth INNER JOIN customers ON yearmonth.customerid = customers.customerid WHERE customers.segment = 'KAM' AND STRFTIME('%Y%m', yearmonth.date) BETWEEN '201201' AND '201212' AND yearmonth.consumption < 30000;

/*
Prediction Result:
(0,)
*/