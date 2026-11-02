-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-01', 'default1', 0, 0, 1, NULL, 0, 548.4), (0, '2023-01-01', 'default1', 0, NULL, 0, 1, 1, 0.0), (2, '2023-01-02', '2012-08-24', 1, 0, 0, 1, 0, 548.4), (3, '2012-08-24', NULL, 0, 1, 0, NULL, 1, 1.0), (4, '2012-08-24', '2012-08-24', 1, NULL, NULL, 0, NULL, 1.0), (5, '2023-01-02', '2012-08-24', 1, 0, NULL, NULL, 0, 549.4), (6, '2012-08-24', 'default1', 1, 0, 0, 1, 0, 548.4), (7, NULL, 'default1', NULL, NULL, 0, 1, NULL, 0.0), (8, NULL, NULL, NULL, 1, 0, 0, 0, 548.4), (9, '2023-01-02', NULL, 0, NULL, NULL, 0, 0, NULL), (10, '2023-01-02', 'default2', 0, 1, NULL, 0, 1, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT gs.Country FROM transactions_1k AS t JOIN gasstations AS gs ON t.GasStationID = gs.GasStationID WHERE CAST(t.Amount AS REAL) * CAST(t.Price AS REAL) = 548.4 AND t.Date = '2012-08-24';

/*
Prediction Result:
*/