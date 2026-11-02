-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (100, '2012-08-25', '2012-08-25', NULL, 100, 99, 99, 101, 101.0), (99, '2012-08-26', 'default2', 1, NULL, 0, 1, 0, 1.0), (2, '2023-01-02', NULL, -1, 1, 100, 99, 101, 2.0), (-1, NULL, 'EUR', 0, 0, 99, -1, 0, 99.0), (1, '2012-08-25', NULL, 101, 1, 2, 101, 100, 99.0), (0, '2023-01-02', NULL, 0, 0, -1, 100, 101, -1.0), (101, '2012-08-25', 'EUR', 1, 99, -1, 0, 100, 99.0);
INSERT INTO customers (customerid, segment, currency) VALUES (-1, NULL, NULL), (2, 'EUR', 'EUR'), (99, 'EUR', '2012-08-25'), (0, '2012-08-25', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(COUNT(DISTINCT T1."customerid") AS REAL) * 100 / (SELECT COUNT(DISTINCT "customerid") FROM "transactions_1k" WHERE "date" = '2012-08-25') FROM "transactions_1k" AS T1 INNER JOIN "customers" AS T2 ON T1."customerid" = T2."customerid" WHERE T2."currency" = 'EUR' AND T1."date" = '2012-08-25';

/*
Prediction Result:
(0.0,)
*/