-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE clause filters (Segment, Currency, Date) and DESC ordering.
-- Customer 2 (Valid, high consumption) should win over Customer 1 (Valid, low consumption).
-- Customers 3, 4, 5 have massive consumption in 201310 or other dates, catching missing WHERE filters.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, NULL, NULL);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201310', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201309', 9000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201310', 250.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201310', 5000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201310', 6000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201310', 7000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.Date = '201310' AND T1.Currency = 'EUR' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T1.Currency = 'Euro' AND T2.Date = '201310' ORDER BY T2.Consumption DESC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/