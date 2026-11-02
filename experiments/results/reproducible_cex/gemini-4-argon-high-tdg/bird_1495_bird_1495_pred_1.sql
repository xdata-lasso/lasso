-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (10, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (20, 'KAM', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (30, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (40, 'LAM', 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 100, 'CZE', 'Value');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2013-09-01', '10:00:00', 40, 1001, 1, 1, 9000, 9000.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '201309', '11:00:00', 40, 1001, 1, 1, 9000, 9000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '201309', 50.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (20, '201309', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (30, '201309', 70.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (40, '201309', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT y.CustomerID FROM yearmonth AS y INNER JOIN transactions_1k AS t ON y.CustomerID = t.CustomerID WHERE y."Date" LIKE '201309%' GROUP BY y.CustomerID ORDER BY SUM(t.Amount) DESC, y.CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
(40,)
*/