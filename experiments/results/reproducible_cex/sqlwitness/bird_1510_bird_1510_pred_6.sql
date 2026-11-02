-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, NULL, 'default2', 0, NULL, NULL, 0, 0, 1.0), (1, NULL, 'CZE', 0, 0, 1, 1, 0, 1.0), (2, NULL, NULL, NULL, 1, 0, 0, 0, 1.0), (3, '2023-01-02', NULL, NULL, 1, 1, 1, 0, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 1, 'CZE', 'default1'), (1, 1, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(transactions_1k.amount * transactions_1k.price) AS averagetotalprice FROM transactions_1k INNER JOIN gasstations ON transactions_1k.gasstationid = gasstations.gasstationid WHERE gasstations.country = 'CZE';

/*
Prediction Result:
(0.0,)
*/