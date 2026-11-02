-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-02', 'EUR', NULL, NULL, 1, 1, 0, 0.0), (0, '2023-01-01', NULL, NULL, 1, 0, 0, 1, 0.0), (2, '2023-01-02', NULL, NULL, 1, 0, 1, 1, NULL), (3, '2023-01-02', NULL, 0, NULL, 0, 1, 1, 1.0), (4, '2023-01-01', 'default1', NULL, 1, 1, 0, NULL, 1.0), (5, '2023-01-01', 'EUR', NULL, NULL, NULL, 0, 1, 0.0), (6, '2023-01-01', 'EUR', NULL, 1, 1, 1, 0, NULL), (7, '2023-01-01', 'default2', 1, 0, NULL, NULL, 0, 0.0), (8, '2023-01-01', 'default2', 0, 1, 0, 0, 0, 0.0), (9, '2023-01-02', 'default1', 0, 1, NULL, NULL, 1, 0.0), (10, '2023-01-02', 'default1', NULL, NULL, 0, NULL, NULL, NULL), (11, '2023-01-01', 'default2', 1, 1, 1, 0, 1, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, 'default2', 'default2'), (1, 0, 'default1', 'default1'), (2, NULL, 'EUR', 'default1'), (3, NULL, 'EUR', 'EUR'), (4, NULL, NULL, 'EUR'), (5, NULL, NULL, 'default1'), (6, 1, NULL, NULL), (7, 1, 'default1', 'default2'), (8, 0, 'EUR', 'default2'), (9, 0, 'EUR', 'default2');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'EUR', 'EUR'), (1, 'default1', NULL), (2, 'default1', 'default2'), (3, 'default1', 'default1'), (4, 'default2', 'EUR'), (5, 'EUR', 'EUR'), (6, NULL, 'EUR'), (7, NULL, NULL), (8, 'EUR', NULL), (9, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT AVG(transactions_1k.amount * transactions_1k.price) AS averagetotalprice FROM customers INNER JOIN transactions_1k ON customers.customerid = transactions_1k.customerid WHERE customers.currency = 'EUR';

/*
Prediction Result:
(0.3333333333333333,)
*/