-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, NULL, NULL, 2, 7, 1, NULL, 6, 6.0), (1, '2023-01-02', 'default1', 0, 0, 6, 2, 1, 0.0), (7, '2023-01-02', '201309', 6, 1, 0, 0, 2, 5.0), (6, '2023-01-01', 'default1', 7, 5, 1, 0, 5, 7.0), (0, '2023-01-01', 'default2', 2, 6, 5, 5, NULL, 6.0), (5, '2023-01-02', 'default1', 5, 2, 0, 5, 7, NULL), (3, '2023-01-01', 'default1', 6, 5, 0, 6, NULL, 6.0), (4, NULL, 'default2', 5, 2, NULL, 5, 2, 2.0), (8, '2023-01-02', 'default1', 7, 2, 0, 5, 2, 1.0);
INSERT INTO products (productid, description) VALUES (7, 'default1'), (2, 'default1'), (0, 'default2'), (6, NULL), (1, '201309'), (5, 'default1'), (3, 'default2'), (4, 'default2');
INSERT INTO customers (customerid, segment, currency) VALUES (7, '201309', 'default1'), (5, NULL, NULL), (0, '201309', 'default2'), (6, 'default2', 'default1'), (2, NULL, 'default1'), (1, NULL, '201309'), (3, 'default2', '201309'), (4, '201309', 'default2'), (8, 'default1', '201309'), (9, '201309', '201309'), (10, '201309', 'default1'), (11, '201309', 'default2'), (12, NULL, 'default1'), (13, 'default1', 'default2'), (14, '201309', NULL), (15, NULL, 'default2'), (16, 'default1', 'default1'), (17, 'default1', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (12, 'default2', 5.0), (13, 'default2', 2.0), (5, '201309', NULL), (6, 'default2', 2.0), (3, 'default1', NULL), (15, 'default1', 6.0), (10, 'default1', 6.0), (0, '201309', 2.0), (1, 'default1', 1.0), (7, '201309', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('default1',)
('default1',)
('default1',)
('default2',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT T3.Description FROM yearmonth AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T2.ProductID = T3.ProductID WHERE SUBSTRING(T1.Date, 1, 6) = '201309';

/*
Prediction Result:
('default1',)
('default2',)
*/