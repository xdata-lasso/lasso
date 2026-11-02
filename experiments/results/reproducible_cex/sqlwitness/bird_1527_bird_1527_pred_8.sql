-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, '2023-01-01', 'default1', 0, NULL, 0, NULL, 2, 1.0), (0, '2023-01-02', 'default2', NULL, 2, 1, NULL, 0, 1.0), (1, NULL, 'default2', NULL, 2, 2, 1, NULL, 0.0), (3, '2023-01-02', 'default1', 2, 1, 1, 1, 1, 1.0), (4, NULL, 'default1', 1, 2, NULL, 2, 1, NULL), (5, NULL, 'default1', 0, 0, 1, 2, 1, 0.0), (6, NULL, 'default2', 2, NULL, NULL, NULL, 0, NULL), (7, '2023-01-01', 'default1', 0, 0, 2, 1, 0, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 1, 'default1', 'default2'), (0, 0, 'default2', 'default2'), (2, NULL, 'default2', NULL), (3, 0, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT GasStationID FROM transactions_1k GROUP BY GasStationID ORDER BY SUM(Price) DESC, GasStationID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T2.GasStationID FROM transactions_1k AS T1 JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID GROUP BY T2.GasStationID ORDER BY SUM(T1.Price * T1.Amount) DESC, T2.GasStationID NULLS LAST LIMIT 1;

/*
Prediction Result:
(0,)
*/