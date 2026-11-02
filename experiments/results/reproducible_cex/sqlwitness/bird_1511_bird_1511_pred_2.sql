-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-02', 'default2', NULL, 1, 1, 1, 0, 0.0), (0, '2023-01-01', 'default2', 1, 0, 0, NULL, 1, 0.0), (2, NULL, NULL, 1, 0, 0, 1, 0, 1.0), (3, '2023-01-02', 'default1', NULL, 0, NULL, 1, 1, NULL), (4, NULL, 'default1', 0, 1, 1, NULL, 0, 0.0), (5, NULL, 'default1', 1, 0, NULL, 0, NULL, 0.0), (6, '2023-01-02', 'default1', NULL, 1, 0, 0, NULL, 0.0), (7, NULL, 'EUR', 1, 1, 1, NULL, 0, 0.0), (8, NULL, NULL, NULL, 1, 0, 1, NULL, 0.0), (9, '2023-01-02', 'default1', NULL, 1, 0, 0, 1, 0.0), (10, '2023-01-01', 'default1', 1, 0, 0, 0, 0, 0.0), (11, '2023-01-01', 'default2', NULL, 1, 0, 0, 1, 1.0), (12, NULL, 'EUR', 0, NULL, 1, 1, 1, NULL), (13, NULL, 'default2', 0, 1, 0, NULL, NULL, 1.0), (14, '2023-01-01', 'EUR', 1, NULL, NULL, NULL, NULL, 1.0), (15, '2023-01-01', 'default2', 1, 1, 1, NULL, 0, 1.0), (16, '2023-01-02', NULL, 1, NULL, NULL, 0, NULL, NULL), (17, NULL, NULL, 0, 0, 0, NULL, NULL, NULL), (18, '2023-01-01', 'EUR', 1, 1, NULL, 1, 0, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, NULL, 'default2');
INSERT INTO customers (customerid, segment, currency) VALUES (0, 'default2', 'EUR'), (1, 'EUR', 'default1'), (2, 'default1', 'default1'), (3, 'default2', 'default2'), (4, NULL, 'default2'), (5, 'default2', 'default2'), (6, 'default1', 'EUR'), (7, 'default1', 'default2'), (8, NULL, 'default1'), (9, 'default1', 'EUR'), (10, 'default1', 'EUR'), (11, 'default1', 'default2'), (12, 'default1', 'EUR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT AVG("t"."price") FROM "transactions_1k" AS "t" INNER JOIN "customers" AS "c" ON "t"."customerid" = "c"."customerid" WHERE "c"."currency" = 'EUR';

/*
Prediction Result:
(0.5,)
*/