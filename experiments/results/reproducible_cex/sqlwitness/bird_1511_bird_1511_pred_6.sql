-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, 'EUR', 0, NULL, 0, NULL, 1, NULL), (0, NULL, NULL, 1, NULL, 0, 1, NULL, 0.0), (2, '2023-01-02', 'default1', 1, 0, 0, 0, 0, 1.0), (3, '2023-01-02', 'EUR', 0, NULL, NULL, 1, 0, NULL), (4, '2023-01-02', 'default2', 0, 1, NULL, 0, 0, 0.0), (5, '2023-01-01', 'EUR', 0, NULL, 1, 0, 0, 0.0), (6, '2023-01-02', 'EUR', 1, 0, NULL, 1, 1, NULL), (7, '2023-01-02', 'EUR', 0, 1, 0, 1, 0, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 0, 'default1', 'default2'), (0, 0, 'EUR', 'default1'), (2, NULL, 'default1', NULL), (3, NULL, 'EUR', 'default2'), (4, 1, 'default1', 'default2'), (5, 0, 'EUR', 'EUR'), (6, 0, NULL, 'default2'), (7, NULL, 'default1', 'default1'), (8, 1, 'EUR', 'default2'), (9, 1, 'EUR', NULL), (10, 0, 'default1', NULL), (11, 0, 'default2', NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default2', 'EUR'), (0, 'EUR', 'EUR'), (2, 'default2', 'default2'), (3, NULL, NULL), (4, 'EUR', 'default2'), (5, 'default2', 'EUR'), (6, NULL, 'default2'), (7, 'default1', 'default1'), (8, 'default2', 'EUR'), (9, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT AVG(T1.Price) AS AverageTotalPrice FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR';

/*
Prediction Result:
(0.4,)
*/