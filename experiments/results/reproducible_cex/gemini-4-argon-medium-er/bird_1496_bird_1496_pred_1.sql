-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'A', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'A', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'B', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201309', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201309', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201309', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201309' GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.Segment NULLS LAST LIMIT 1;

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT c.Segment FROM customers AS c INNER JOIN yearmonth AS ym ON c.CustomerID = ym.CustomerID WHERE ym.Date = '201309' GROUP BY c.Segment ORDER BY SUM(ym.Consumption) ASC, c.Segment NULLS LAST LIMIT 1;

/*
Prediction Result:
('B',)
*/