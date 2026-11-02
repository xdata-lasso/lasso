-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', 'default2', NULL, NULL, 1, 0, 0, 0.0), (1, NULL, NULL, 0, 0, NULL, 0, 1, 1.0), (2, '2023-01-01', NULL, 0, NULL, 0, 0, 1, NULL), (3, '2023-01-02', NULL, 0, 1, 1, 1, 1, 1.0), (4, '2023-01-01', 'default2', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO products (productid, description) VALUES (1, '201309'), (0, 'default1'), (2, 'default1'), (3, 'default2'), (4, 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (0, NULL, 'default2'), (1, NULL, 'default2'), (2, 'default2', 'default2'), (3, '201309', NULL), (4, NULL, 'default1'), (5, NULL, 'default1'), (6, '201309', '201309'), (7, 'default2', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (4, '201309', 1.0), (0, 'default1', 0.0), (6, 'default1', 1.0), (7, '201309', 1.0), (7, 'default1', NULL), (6, '201309', 0.0), (0, '201309', NULL), (1, 'default1', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('default1',)
('default1',)
('201309',)
*/

-- Prediction Query
SELECT DISTINCT p.Description FROM products AS p INNER JOIN transactions_1k AS t ON p.ProductID = t.ProductID INNER JOIN yearmonth AS y ON t.CustomerID = y.CustomerID WHERE y.Date = '201309';

/*
Prediction Result:
('default1',)
('201309',)
*/