-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, NULL, 'default2', 1, 1, 1, 0, 0, 0.0), (1, '2023-01-02', 'default2', 0, 1, NULL, 1, 0, 1.0), (2, '2023-01-02', 'default2', NULL, NULL, NULL, 1, NULL, 0.0), (3, '2023-01-02', 'default1', 1, 1, NULL, 0, 0, NULL), (4, NULL, '201306', 1, 0, 1, 1, 1, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 0, NULL, 'default2'), (0, 1, 'default2', '201306'), (2, 0, NULL, NULL), (3, 0, 'default1', '201306'), (4, 1, NULL, 'default1'), (5, NULL, NULL, 'default2'), (6, 1, 'default1', 'default2'), (7, 0, NULL, 'default2'), (8, NULL, 'default1', NULL), (9, NULL, 'default2', 'default2'), (10, NULL, '201306', 'default1'), (11, 0, 'default2', NULL), (12, 0, '201306', '201306'), (13, 0, 'default1', NULL), (14, 0, '201306', NULL), (15, 1, '201306', 'default1'), (16, 0, 'default2', NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default2', 'default2'), (0, 'default1', '201306'), (2, NULL, 'default1'), (3, NULL, 'default2'), (4, NULL, 'default2'), (5, '201306', NULL), (6, '201306', NULL), (7, '201306', 'default2'), (8, NULL, NULL), (9, 'default1', 'default1'), (10, 'default2', 'default1'), (11, 'default1', 'default1'), (12, '201306', NULL), (13, 'default1', '201306'), (14, '201306', '201306');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (13, 'default2', NULL), (9, 'default1', 1.0), (3, 'default2', NULL), (0, '201306', 1.0), (0, 'default1', 1.0), (2, '201306', NULL), (1, 'default2', 1.0), (13, 'default1', 1.0), (2, 'default1', 0.0), (8, '201306', 1.0), (3, 'default1', 0.0), (3, '201306', 0.0), (10, 'default1', 1.0), (1, '201306', 0.0), (1, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT gasstations.Country FROM gasstations INNER JOIN transactions_1k ON gasstations.GasStationID = transactions_1k.GasStationID INNER JOIN yearmonth ON transactions_1k.CustomerID = yearmonth.CustomerID WHERE yearmonth.Date = '201306';

/*
Prediction Result:
(None,)
*/