-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (101, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (102, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (103, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (104, 'LAM', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (101, '201203', 12.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (101, '201204', 13.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (102, '201203', 30.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (103, '201203', 5.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (103, '201204', 45.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (104, '201203', 8.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (104, '201204', 8.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (104, '201205', 8.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (104, '201206', 8.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.date BETWEEN 201201 AND 201212 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT c.CustomerID FROM yearmonth AS y JOIN customers AS c ON y.CustomerID = c.CustomerID WHERE SUBSTRING(y.Date, 1, 6) BETWEEN '201201' AND '201212' AND c.Segment = 'LAM' ORDER BY y.Consumption ASC, y.date NULLS LAST, y.customerid NULLS LAST, c.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(103,)
*/