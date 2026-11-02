-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default1', 'default2'), (201211, 'KAM', 'default2'), (2, 'default2', NULL), (201213, NULL, 'default1'), (30000, 'KAM', 'default2'), (201202, 'default1', NULL), (30001, 'default2', 'default2'), (4, 'KAM', 'default2'), (1, 'default2', '2012'), (3, '2012', '2012'), (5, 'default2', 'default1'), (29999, NULL, 'default2'), (201201, NULL, 'default2'), (201200, 'KAM', '2012');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (5, 'KAM', 201202.0), (30001, 'KAM', 201212.0), (29999, 'default2', 1.0), (30000, '2012', 4.0), (1, 'KAM', 201200.0), (5, '2012', 201211.0), (0, 'default1', 201201.0), (5, 'default2', 3.0), (0, '2012', 3.0), (201213, 'KAM', 201212.0), (30001, 'default1', 30001.0), (201200, 'KAM', 201201.0), (2, 'KAM', 201213.0), (0, 'KAM', 201212.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND T2.Date BETWEEN 201201 AND 201212 AND T2.Consumption < 30000;

/*
Prediction Result:
(0,)
*/