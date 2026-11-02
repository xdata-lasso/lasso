-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, 'CZE', 1, NULL, 1, NULL, 0, 1.0), (0, '2023-01-02', 'default2', 0, NULL, NULL, 0, 0, 1.0), (2, NULL, 'default2', 0, 1, 1, 1, NULL, 0.0), (3, NULL, 'CZE', 0, 1, 0, 1, NULL, 0.0), (4, '2023-01-02', 'default2', 0, 1, NULL, NULL, NULL, 0.0), (5, '2023-01-02', 'CZE', 1, NULL, 1, NULL, NULL, NULL), (6, NULL, 'default2', 0, NULL, 0, NULL, NULL, NULL), (7, NULL, 'CZE', 1, NULL, 0, 1, NULL, NULL), (8, '2023-01-01', 'default2', 1, 0, 0, 0, NULL, 1.0), (9, '2023-01-01', 'default2', NULL, 0, 1, 0, 1, 0.0), (10, '2023-01-01', NULL, 0, 0, 1, 0, 0, 0.0), (11, '2023-01-02', 'default1', NULL, 1, 0, NULL, NULL, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, 'default2', NULL), (1, NULL, 'CZE', 'default1'), (2, 0, 'default2', 'CZE'), (3, 1, 'CZE', NULL), (4, 1, NULL, NULL), (5, 0, NULL, 'default1'), (6, 0, 'default1', 'CZE'), (7, 0, 'default1', 'CZE'), (8, NULL, NULL, NULL), (9, 0, 'default2', 'default1'), (10, 0, 'default2', 'CZE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Gold Result:
(0.25,)
*/

-- Prediction Query
SELECT AVG("price" * "amount") FROM "transactions_1k" INNER JOIN "gasstations" ON "transactions_1k"."gasstationid" = "gasstations"."gasstationid" WHERE "gasstations"."country" = 'CZE';

/*
Prediction Result:
(0.0,)
*/