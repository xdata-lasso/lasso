-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-08-24', NULL, NULL, 1, NULL, 1, NULL, 1.0), (1, '2023-01-02', '2012-08-24', NULL, 0, 1, NULL, NULL, NULL), (2, '2012-08-24', '16:25:00', 1, NULL, NULL, NULL, 0, 0.0), (3, NULL, 'default1', 0, 1, NULL, NULL, 0, 0.0), (4, '2023-01-01', NULL, 1, NULL, 1, NULL, 0, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 0, 'default2', '2012-08-24'), (1, NULL, NULL, 'default2');
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default1', '16:25:00'), (0, 'default2', 'default2'), (2, '16:25:00', '16:25:00'), (3, NULL, NULL), (4, 'default1', NULL), (5, '16:25:00', '16:25:00'), (6, 'default1', '2012-08-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Currency FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Time = '16:25:00' AND T1.Date = '2012-08-24';

/*
Prediction Result:
('16:25:00',)
*/