-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, NULL, NULL, NULL, 0, NULL, 1, 0, NULL), (1, NULL, 'default2', 0, 1, 0, 1, 0, NULL), (2, NULL, 'Euro', 1, NULL, 0, NULL, 0, NULL), (3, NULL, 'Euro', 0, NULL, 0, 0, NULL, 0.0), (4, NULL, 'default2', 0, 1, 1, 1, 1, 1.0), (5, NULL, 'default2', 0, 1, 1, 0, NULL, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 0, 'Euro', 'Euro'), (1, 1, 'default1', NULL), (2, 1, 'default1', 'default2'), (3, 1, 'EUR', NULL), (4, NULL, NULL, 'EUR'), (5, 0, NULL, 'default2'), (6, 1, 'EUR', 'default1'), (7, 1, 'default1', 'Euro');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'Euro', 'EUR'), (1, 'default2', 'EUR'), (2, NULL, NULL), (3, 'Euro', 'default1'), (4, 'default2', 'Euro'), (5, 'EUR', 'Euro'), (6, 'default2', 'Euro');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.ChainID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.Currency = 'EUR';

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT T3.ChainID FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T2.GasStationID = T3.GasStationID WHERE T1.Currency = 'Euro';

/*
Prediction Result:
*/