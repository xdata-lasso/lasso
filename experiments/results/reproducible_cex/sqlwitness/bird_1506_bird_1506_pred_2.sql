-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', 'CZE', 1, 0, 1, 0, 1, NULL), (1, NULL, NULL, 0, 1, NULL, NULL, 0, NULL), (2, '2023-01-02', 'default1', 1, 0, 0, 1, 0, 1.0), (3, NULL, 'default1', 1, 0, 0, 0, NULL, NULL), (4, NULL, 'CZE', NULL, NULL, 1, 0, 1, 0.0), (5, '2023-01-02', 'default1', 0, 0, NULL, 1, 1, 1.0), (6, '2023-01-01', 'CZE', NULL, 0, NULL, 0, NULL, NULL), (7, NULL, 'default2', 0, NULL, 0, 1, 1, NULL), (8, '2023-01-01', NULL, NULL, NULL, NULL, 0, 0, NULL), (9, '2023-01-01', 'CZE', NULL, NULL, 0, NULL, 1, NULL), (10, '2023-01-01', NULL, NULL, 1, 0, 1, 0, 0.0), (11, '2023-01-02', 'CZE', 0, 1, NULL, 1, NULL, 1.0), (12, '2023-01-02', 'default2', NULL, 1, NULL, 0, NULL, 0.0), (13, '2023-01-02', 'default1', 1, NULL, 1, NULL, 1, NULL), (14, '2023-01-01', 'CZE', NULL, 0, NULL, 0, 0, 0.0), (15, NULL, 'CZE', NULL, NULL, NULL, 1, NULL, 0.0), (16, '2023-01-02', NULL, 0, 0, 1, 1, 0, 1.0);
INSERT INTO products (productid, description) VALUES (0, 'default2'), (1, NULL), (2, 'default1'), (3, 'default1'), (4, 'CZE'), (5, 'default2'), (6, 'default2'), (7, 'default1'), (8, 'default1'), (9, 'CZE'), (10, 'default1'), (11, 'CZE'), (12, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 0, 'default2', 'default2'), (0, 1, 'CZE', 'default1'), (2, 1, NULL, NULL), (3, 0, 'default2', 'CZE'), (4, 0, NULL, 'default2'), (5, 0, 'default1', 'CZE'), (6, 1, 'CZE', NULL), (7, 0, 'default1', NULL), (8, NULL, 'CZE', 'CZE'), (9, 1, 'CZE', 'default1'), (10, 0, 'default1', 'CZE'), (11, NULL, NULL, 'default2'), (12, 1, 'default1', 'default2'), (13, NULL, 'default2', 'CZE'), (14, 1, NULL, 'default2'), (15, 0, 'CZE', 'default1'), (16, 0, 'default1', 'CZE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Country = 'CZE';

/*
Gold Result:
(None,)
('default2',)
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT "products"."description" FROM "transactions_1k" INNER JOIN "gasstations" ON "transactions_1k"."gasstationid" = "gasstations"."gasstationid" INNER JOIN "products" ON "transactions_1k"."productid" = "products"."productid" WHERE "gasstations"."country" = 'CZE';

/*
Prediction Result:
(None,)
('default2',)
*/