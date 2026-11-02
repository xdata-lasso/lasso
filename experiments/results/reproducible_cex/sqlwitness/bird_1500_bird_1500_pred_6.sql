-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-02', 'default1', 1, 0, 0, 0, 0, 0.0), (0, '2023-01-01', '201309%', 0, 1, 0, 1, 0, 0.0), (2, '2023-01-01', 'default1', 1, 0, 1, NULL, 1, 0.0);
INSERT INTO products (productid, description) VALUES (1, '201309'), (0, 'default2'), (2, NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (0, NULL, '201309'), (1, NULL, 'default2'), (2, 'default2', 'default2'), (3, 'default1', '201309');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (3, '201309%', NULL), (0, '201309%', 1.0), (1, '201309%', 1.0), (2, '201309', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
*/

-- Prediction Query
SELECT products.Description FROM transactions_1k INNER JOIN yearmonth ON transactions_1k.CustomerID = yearmonth.CustomerID INNER JOIN products ON transactions_1k.ProductID = products.ProductID WHERE yearmonth."Date" LIKE '201309%';

/*
Prediction Result:
('201309',)
('default2',)
*/