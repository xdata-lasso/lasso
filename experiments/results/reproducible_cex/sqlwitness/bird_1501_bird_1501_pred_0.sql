-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (5, NULL, NULL, 7, 5, 5, 5, NULL, 0.0), (1, '2023-01-01', '201306', NULL, 1, 7, 7, 5, 0.0), (2, '2023-01-01', NULL, 5, 0, 6, NULL, NULL, 1.0), (0, NULL, 'default1', 6, 0, 5, 2, 0, 0.0), (6, '2023-01-01', NULL, 7, 7, 2, 2, 2, 5.0), (7, '2023-01-01', 'default1', 7, 6, 1, 6, 6, NULL), (3, NULL, 'default1', 1, 1, 6, 6, 2, 6.0), (4, '2023-01-02', 'default2', 1, 7, NULL, 0, 0, 0.0), (8, '2023-01-02', 'default2', 1, 0, 7, 6, 1, 2.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (5, 2, '201306', 'default1'), (7, 7, 'default2', '201306'), (0, 0, NULL, 'default1'), (1, 7, NULL, NULL), (2, NULL, 'default2', 'default1'), (6, NULL, '201306', 'default1'), (3, 7, '201306', 'default2');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default2', 'default2'), (5, NULL, 'default2'), (7, NULL, 'default2'), (6, NULL, 'default1'), (1, 'default2', NULL), (2, 'default1', 'default2'), (3, 'default2', 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (0, '201306', 7.0), (0, 'default1', NULL), (6, 'default2', 6.0), (5, 'default1', 1.0), (6, '201306', 0.0), (1, 'default1', NULL), (0, 'default2', 7.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('201306',)
*/

-- Prediction Query
SELECT DISTINCT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE SUBSTRING(T1.Date, 1, 6) = '201306';

/*
Prediction Result:
*/