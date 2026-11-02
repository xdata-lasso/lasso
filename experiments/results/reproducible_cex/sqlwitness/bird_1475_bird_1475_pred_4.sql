-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (201201, 'default2', 'default2'), (1, 'default1', 'KAM'), (3, '2012', 'default2'), (29999, '2012', NULL), (2, 'KAM', 'default1'), (5, '2012', '2012'), (201211, 'default2', '2012'), (201212, 'KAM', 'KAM'), (0, NULL, 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (201212, 'default2', 3.0), (201212, 'KAM', 0.0), (201211, 'KAM', 201200.0), (201212, '2012', 0.0), (2, 'KAM', 5.0), (5, 'KAM', 201202.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT y.CustomerID) FROM yearmonth AS y JOIN customers AS c ON y.CustomerID = c.CustomerID WHERE c.Segment = 'KAM' AND y.Consumption < 30000 AND y.Date BETWEEN 201201 AND 201212;

/*
Prediction Result:
(0,)
*/