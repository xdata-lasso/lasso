-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, '%Y%m', 1, NULL, 1, 1, 0, NULL), (0, '2023-01-02', '%Y%m', 1, 0, 0, 0, NULL, 0.0), (2, NULL, 'default2', 1, 0, NULL, NULL, NULL, 0.0), (3, NULL, 'default2', 0, 0, NULL, NULL, NULL, 1.0), (4, NULL, NULL, 1, 0, NULL, 0, NULL, 0.0), (5, '2023-01-02', NULL, 0, 1, 1, NULL, 0, 0.0), (6, '2023-01-01', '%Y%m', NULL, 1, NULL, 0, 0, 1.0), (7, '2023-01-01', 'default1', 1, 1, NULL, 0, 0, 0.0), (8, '2023-01-02', 'default2', 0, 1, 1, 0, NULL, 1.0), (9, '2023-01-02', '201309', 1, NULL, 1, NULL, 1, NULL), (10, NULL, '201309', NULL, NULL, NULL, 1, 0, 0.0), (11, NULL, '201309', 0, 0, 1, NULL, 0, NULL);
INSERT INTO products (productid, description) VALUES (0, 'default2'), (1, NULL), (2, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'default2'), (6, '201309'), (7, NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default2', 'default1'), (0, 'default1', '%Y%m'), (2, NULL, '%Y%m'), (3, 'default1', NULL), (4, '201309', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (0, 'default1', 1.0), (0, '201309', NULL), (0, '%Y%m', 0.0), (4, '201309', 0.0), (2, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT DISTINCT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID WHERE STRFTIME('%Y%m', T1.Date) = '201309';

/*
Prediction Result:
*/