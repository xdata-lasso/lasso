-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', 'EUR', NULL, 1, NULL, 1, 1, 0.0), (1, '2023-01-02', 'default1', NULL, 1, 0, NULL, 1, 1.0), (2, '2023-01-02', 'default2', 1, 0, NULL, NULL, NULL, NULL), (3, '2023-01-02', NULL, 0, 1, 0, NULL, 0, 0.0), (4, '2023-01-02', 'default2', 1, 0, NULL, NULL, 0, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, 'EUR', 'default1'), (1, NULL, 'EUR', NULL), (2, 1, 'default1', 'default1'), (3, 0, 'default2', NULL), (4, 0, 'EUR', 'EUR'), (5, NULL, 'default2', 'EUR'), (6, 1, 'default1', 'default2'), (7, 0, 'EUR', 'default2'), (8, 0, 'default1', NULL), (9, NULL, NULL, 'default1'), (10, NULL, 'default1', 'EUR'), (11, NULL, 'default1', 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default2', 'default1'), (1, 'default2', 'EUR'), (2, NULL, 'default2'), (3, NULL, 'default2'), (4, NULL, 'default2'), (5, 'default2', NULL), (6, 'EUR', 'default1'), (7, NULL, 'default1'), (8, NULL, NULL), (9, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(T1.Amount * T1.Price) AS AverageTotalPrice FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR';

/*
Prediction Result:
(0.0,)
*/