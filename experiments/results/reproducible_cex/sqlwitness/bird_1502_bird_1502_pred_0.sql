-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', 'default2', 0, 0, 1, NULL, NULL, NULL), (1, '2023-01-01', NULL, 1, 0, 1, NULL, NULL, 1.0), (2, '2023-01-02', 'default2', NULL, 0, 1, 1, 1, 0.0), (3, NULL, NULL, NULL, 0, 1, 1, NULL, NULL), (4, '2023-01-02', 'default1', NULL, NULL, 0, 1, NULL, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 0, 'default2', NULL), (1, NULL, NULL, NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'Euro', 'Euro'), (1, 'Euro', NULL), (2, 'default1', 'default1'), (3, 'default1', NULL), (4, NULL, 'EUR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.ChainID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.Currency = 'EUR';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T2.ChainID FROM gasstations AS T2 INNER JOIN transactions_1k AS T1 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'Euro';

/*
Prediction Result:
(None,)
*/