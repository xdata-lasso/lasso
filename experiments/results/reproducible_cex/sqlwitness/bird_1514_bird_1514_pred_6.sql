-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-08-25', 'default1', 0, 1, NULL, NULL, NULL, NULL), (1, '2012-08-24', '16:25:00', 0, 0, NULL, 0, NULL, NULL), (2, '2023-01-02', '2012-08-24', NULL, 1, NULL, 1, 1, NULL), (3, '2023-01-01', NULL, NULL, NULL, 0, NULL, 1, 0.0), (4, NULL, 'default2', 0, 1, 1, NULL, 1, 1.0), (5, '2012-08-25', NULL, NULL, NULL, NULL, 1, NULL, NULL), (6, '2012-08-24', NULL, 1, NULL, 0, 0, 1, 0.0), (7, '2012-08-23', '16:25:00', NULL, NULL, 1, 0, 1, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, 'default2', 'default1'), (0, 0, '2012-08-24', NULL), (2, 0, '16:25:00', '16:25:00');
INSERT INTO customers (customerid, segment, currency) VALUES (1, NULL, NULL), (0, '16:25:00', NULL), (2, 'default2', 'default2'), (3, 'default2', 'default2'), (4, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT customers.currency FROM transactions_1k INNER JOIN customers ON transactions_1k.customerid = customers.customerid WHERE transactions_1k.date = '2012-08-24' AND transactions_1k.time = '16:25:00';

/*
Prediction Result:
(None,)
*/