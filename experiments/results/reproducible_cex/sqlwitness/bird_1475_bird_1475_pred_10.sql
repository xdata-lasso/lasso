-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (4, 'KAM', 'KAM'), (29999, 'default2', '201212'), (30001, '2012', 'KAM'), (2, '201212', NULL), (30000, NULL, 'KAM'), (1, 'default2', '201201'), (3, 'KAM', '201212'), (0, 'KAM', NULL), (5, 'default2', NULL), (6, '2012', 'default2'), (7, 'KAM', 'KAM'), (8, 'default2', 'default2'), (9, 'default2', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (9, '201201', 30000.0), (9, 'default1', 5.0), (4, '201201', NULL), (4, 'default1', 5.0), (1, 'KAM', 29999.0), (7, '201212', 5.0), (4, 'KAM', 3.0), (2, 'default1', 29999.0), (1, 'default2', 3.0), (5, '201201', 30000.0), (6, 'default1', 4.0), (0, '2012', 1.0), (0, '201212', 29999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(CustomerID) FROM (SELECT c.CustomerID FROM customers AS c JOIN yearmonth AS y ON c.CustomerID = y.CustomerID WHERE c.Segment = 'KAM' AND y.Date BETWEEN '201201' AND '201212' GROUP BY c.CustomerID HAVING SUM(y.Consumption) < 30000) AS kam_customers;

/*
Prediction Result:
(2,)
*/