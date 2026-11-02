-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (101, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (102, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (103, 'KAM', 'CZK');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (101, '201201', 12000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (101, '201202', 15000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (102, '201201', 18000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (102, '201202', 16000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (103, '201203', 10000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND T2.Date BETWEEN '201201' AND '201212' AND T2.Consumption < 30000;

/*
Prediction Result:
(5,)
*/