-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, '2012-08-24', '2012-08-25', 2, 0, NULL, 2, NULL, 2.0), (1, '2012-08-26', NULL, 0, 2, 0, 0, 0, NULL), (0, NULL, NULL, 1, NULL, NULL, 0, 0, NULL), (3, '2012-08-25', 'default2', 1, 1, 1, 0, 1, 2.0), (4, '2023-01-01', 'default1', 0, 1, 2, 0, NULL, NULL), (5, '2023-01-01', '2012-08-25', NULL, 1, 2, NULL, 0, 2.0), (6, '2023-01-01', 'default2', 2, 0, NULL, NULL, 0, NULL), (7, NULL, 'default1', 2, 2, 1, 2, 0, 2.0), (8, '2023-01-02', 'default1', 1, NULL, 2, 2, 2, 1.0), (9, '2023-01-01', 'default2', 1, 1, 1, 1, 2, 0.0), (10, NULL, '2012-08-25', 0, 1, NULL, 1, 1, 2.0), (11, '2023-01-01', 'default1', 0, NULL, 2, NULL, NULL, 1.0), (12, '2012-08-25', 'default1', 0, 2, 0, 1, 1, NULL), (13, NULL, '2012-08-25', 2, 0, NULL, NULL, NULL, 1.0), (14, '2012-08-26', '2012-08-25', 2, NULL, NULL, 1, 1, 0.0), (15, '2023-01-02', NULL, 2, NULL, 1, 1, 1, 0.0), (16, '2012-08-25', NULL, 2, 0, 2, 1, 2, 2.0), (17, '2012-08-26', 'default2', NULL, 2, NULL, 0, NULL, 1.0), (18, NULL, 'default2', NULL, NULL, NULL, NULL, NULL, 0.0), (19, '2023-01-02', NULL, 1, 2, 0, NULL, NULL, 1.0), (20, '2012-08-24', NULL, 0, 2, 1, 2, 0, 2.0), (21, '2012-08-26', 'default2', 0, NULL, 2, 1, 2, 0.0), (22, NULL, 'default2', 1, 1, NULL, 1, NULL, NULL), (23, NULL, NULL, 1, 0, 0, 2, 1, 2.0), (24, NULL, 'default2', 0, 1, 2, 1, 1, 1.0), (25, NULL, '2012-08-25', 1, 0, NULL, 0, 0, NULL), (26, '2012-08-24', NULL, 0, 1, 0, 0, 1, 0.0), (27, '2012-08-25', 'default2', NULL, 2, 1, 0, 2, 2.0), (28, '2012-08-24', 'default1', 1, 0, 1, NULL, 2, 0.0), (29, '2012-08-24', '2012-08-25', 0, 2, 0, 1, NULL, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-25' GROUP BY CustomerID ORDER BY SUM(Price) DESC, CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT "customerid" FROM "transactions_1k" WHERE "date" = '2012-08-25' GROUP BY "customerid" ORDER BY SUM("price" * "amount") DESC, "customerid" NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/