-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests boundary conditions for Date BETWEEN 201201 AND 201212 (inclusive vs exclusive bounds, out-of-range dates).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (10, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (20, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (30, 'LAM', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '201112', 5.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '201201', 50.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '201212', 50.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '201301', 5.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (20, '201206', 80.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (30, '201112', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.date BETWEEN 201201 AND 201212 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.Date LIKE '2012%' ORDER BY T2.Consumption, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/