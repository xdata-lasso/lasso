-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, NULL, 'default2', 7, 6, 0, 7, 2, 2.0), (1, '2023-01-01', '201309', 5, 6, 2, 7, NULL, 6.0), (6, '2023-01-02', 'default1', 7, 6, 5, 1, 6, 6.0), (2, '2023-01-02', '201309', 0, 2, 6, 0, 1, 5.0), (5, NULL, NULL, 5, 6, 1, 2, 5, 0.0);
INSERT INTO products (productid, description) VALUES (2, 'default1'), (0, NULL), (7, 'default1'), (1, 'default2'), (6, 'default1'), (5, 'default1'), (3, '201309'), (4, '201309');
INSERT INTO customers (customerid, segment, currency) VALUES (0, '201309', 'default2'), (2, 'default2', '201309'), (1, '201309', 'default1'), (5, '201309', '201309'), (6, 'default1', NULL), (7, NULL, '201309'), (3, 'default1', 'default2'), (4, 'default1', '201309');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (4, 'default1', 0.0), (0, 'default1', 0.0), (5, 'default2', NULL), (7, 'default1', 5.0), (2, 'default1', 5.0), (0, '201309', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.Description FROM "transactions_1k" AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID WHERE SUBSTRING(T1.Date, 1, 6) = '201309';

/*
Prediction Result:
*/