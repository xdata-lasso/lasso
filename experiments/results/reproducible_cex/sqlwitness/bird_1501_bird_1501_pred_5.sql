-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', '201306', 1, 1, 0, 0, 0, NULL), (1, '2023-01-02', NULL, NULL, 0, 0, 0, 0, 1.0), (2, '2023-01-01', 'default2', NULL, NULL, 1, 0, 0, 0.0), (3, NULL, 'default2', NULL, NULL, 1, 0, NULL, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, '2012-08-%', '201306'), (1, NULL, '2012-08-%', NULL), (2, 1, 'default1', NULL), (3, NULL, NULL, 'default1'), (4, 1, '2012-08-%', NULL), (5, NULL, 'default2', '201306');
INSERT INTO customers (customerid, segment, currency) VALUES (1, '2012-08-%', 'default2'), (0, '201306', NULL), (2, '2012-08-%', '2012-08-%'), (3, 'default1', NULL), (4, NULL, '2012-08-%'), (5, 'default2', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (2, 'default2', NULL), (4, 'default1', 1.0), (2, '2012-08-%', NULL), (1, 'default2', NULL), (1, '2012-08-%', NULL), (1, '201306', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('2012-08-%',)
*/

-- Prediction Query
SELECT DISTINCT T2.Country FROM transactions_1k AS T1 JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date LIKE '2012-08-%';

/*
Prediction Result:
*/