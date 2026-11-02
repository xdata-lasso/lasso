-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests SUM vs MAX/AVG/COUNT, Currency filter ('CZK'), Date range filter, and ORDER BY DESC vs ASC.
-- Customer 1 has highest SUM (300) for CZK in 2011, Customer 2 has highest MAX (250) and AVG (250), Customer 3 has highest SUM (1000) but wrong currency, Customer 4 has highest SUM (2000) but outside date range, Customer 5 has lowest SUM (50) to kill ASC sorting.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'SME', 'CZK');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201102', 120.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201105', 180.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201103', 250.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201104', 1000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201012', 2000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201201', 2000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201106', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Date BETWEEN 201101 AND 201112 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date BETWEEN 201101 AND 201112 AND T1.Currency = 'CZK' ORDER BY T2.Consumption DESC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/