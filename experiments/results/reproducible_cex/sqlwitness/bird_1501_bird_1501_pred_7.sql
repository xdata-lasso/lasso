-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (5, '2023-01-02', 'default1', 7, 7, 0, 2, 7, 5.0), (7, NULL, NULL, NULL, 1, 2, 6, 0, 7.0), (1, '2023-01-02', 'default1', 0, 7, NULL, 5, 1, 0.0), (0, NULL, 'default2', 5, 6, 0, NULL, 7, 5.0), (2, NULL, 'default2', 0, NULL, 0, 0, 1, NULL), (6, '2023-01-01', '201306', 6, NULL, 7, 6, 6, 0.0), (3, '2023-01-02', 'default2', 2, 0, 6, 0, 6, 2.0), (4, '2023-01-02', 'default1', 6, 2, 2, 0, NULL, 2.0), (8, '2023-01-01', NULL, NULL, 5, 6, NULL, 1, 7.0), (9, '2023-01-02', '201306', 1, 2, 2, 7, 1, NULL), (10, NULL, 'default2', NULL, 1, 1, 6, NULL, 2.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (5, 7, NULL, '201306'), (1, 1, 'default1', '201306'), (0, 7, 'default1', 'default2'), (2, NULL, '201306', 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (5, NULL, NULL), (0, NULL, 'default1'), (1, 'default2', NULL), (2, 'default2', 'default2'), (6, '201306', '201306'), (7, '201306', 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (2, 'default2', 6.0), (7, '201306', NULL), (1, 'default2', 0.0), (5, '201306', 7.0), (5, 'default1', 2.0), (6, '201306', 6.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('default1',)
('201306',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT gasstations.country FROM transactions_1k INNER JOIN yearmonth ON transactions_1k.customerid = yearmonth.customerid INNER JOIN gasstations ON transactions_1k.gasstationid = gasstations.gasstationid WHERE SUBSTRING(yearmonth.date, 1, 6) = '201306';

/*
Prediction Result:
('default1',)
('201306',)
*/