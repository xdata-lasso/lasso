-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', NULL, 1, 1, 0, NULL, 0, 0.0), (1, '2023-01-02', 'Euro', NULL, NULL, 0, 0, 0, 0.0), (2, '2023-01-01', NULL, 1, 0, NULL, NULL, 0, 1.0), (3, NULL, 'default1', 0, 0, 0, 0, 1, NULL), (4, '2023-01-01', 'EUR', NULL, 1, 0, 1, 0, 0.0), (5, '2023-01-02', 'default2', 0, 0, 1, 1, 1, 1.0), (6, NULL, 'default1', 1, 0, 0, NULL, 1, NULL), (7, '2023-01-01', NULL, NULL, NULL, 0, NULL, 1, 0.0), (8, NULL, 'default2', 0, 0, 1, 0, NULL, 1.0), (9, '2023-01-02', NULL, 1, 1, NULL, 1, 1, 1.0), (10, NULL, 'default1', NULL, 0, 1, 1, 1, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 1, 'EUR', 'default1'), (0, 0, 'default1', 'EUR'), (2, NULL, NULL, 'EUR'), (3, NULL, 'default2', 'Euro'), (4, 1, 'default1', 'Euro'), (5, NULL, 'Euro', 'EUR'), (6, 0, 'default2', NULL), (7, 1, 'default1', 'default1'), (8, 0, 'default2', 'Euro');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'Euro', 'Euro'), (1, 'default1', NULL), (2, NULL, 'default1'), (3, 'default1', 'Euro'), (4, 'EUR', 'default1'), (5, 'default2', 'default1'), (6, 'default1', 'Euro'), (7, 'default2', 'Euro'), (8, 'default1', 'EUR'), (9, 'default2', 'EUR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.ChainID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.Currency = 'EUR';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT gasstations.chainid FROM gasstations INNER JOIN transactions_1k ON gasstations.gasstationid = transactions_1k.gasstationid INNER JOIN customers ON transactions_1k.customerid = customers.customerid WHERE customers.currency IN ('Euro', 'EUR');

/*
Prediction Result:
(0,)
(1,)
*/