-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests SUM vs MAX/AVG/COUNT, ORDER BY DESC vs ASC, and WHERE filters (Currency = 'CZK', Date boundaries).
-- Customer 1 wins because 60 + 60 = 120 > 100 (Customer 2).
-- Customer 3 has higher consumption (500) but wrong currency ('EUR').
-- Customer 4 has higher consumption (500) just outside the date range (201012 and 201201).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'LAM', 'CZK');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201101', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201112', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201106', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201106', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201012', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201201', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201105', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Date BETWEEN 201101 AND 201112 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT c.CustomerID FROM customers AS c JOIN yearmonth AS ym ON c.CustomerID = ym.CustomerID WHERE c.Currency = 'CZK' AND ym.Date BETWEEN 201101 AND 201112 ORDER BY ym.Consumption DESC, c.customerid NULLS LAST, ym.date NULLS LAST, ym.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/