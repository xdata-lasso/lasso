-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, 'default1', NULL, 1, 1, 0, NULL, 0.0), (0, '2023-01-01', 'default1', NULL, 0, 1, 0, NULL, NULL), (2, NULL, '201309', 0, 0, NULL, NULL, 0, NULL), (3, '2023-01-01', '201309', NULL, NULL, 0, NULL, 1, 1.0), (4, '2023-01-02', '201309', 1, 0, 1, 0, NULL, NULL), (5, NULL, NULL, 1, 1, NULL, 0, NULL, 0.0), (6, '2023-01-01', 'default1', 1, 1, NULL, 1, NULL, 1.0), (7, '2023-01-01', NULL, 0, 1, 0, NULL, 0, NULL), (8, '2023-01-01', 'default2', 1, NULL, 1, 1, 1, 1.0), (9, '2023-01-02', NULL, 0, 0, 1, 1, 0, 0.0), (10, '2023-01-02', 'default1', NULL, 1, 1, 0, NULL, NULL), (11, '2023-01-02', NULL, NULL, NULL, 1, 0, 0, 1.0), (12, '2023-01-02', 'default1', NULL, 1, 1, 0, 1, 0.0), (13, '2023-01-01', NULL, 0, 0, 1, 1, NULL, 1.0);
INSERT INTO products (productid, description) VALUES (1, NULL), (0, NULL), (2, '201309'), (3, 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (1, '201309', 'default2'), (0, '201309', 'default1'), (2, NULL, '201309'), (3, 'default2', 'default2'), (4, 'default2', '201309'), (5, NULL, NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, '201309', 0.0), (1, 'default1', NULL), (2, '201309', 1.0), (1, 'default2', 0.0), (5, '201309', 0.0), (3, '201309', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT "products"."description" FROM "products" INNER JOIN "transactions_1k" ON "products"."productid" = "transactions_1k"."productid" INNER JOIN "yearmonth" ON "transactions_1k"."customerid" = "yearmonth"."customerid" WHERE "yearmonth"."date" = '201309';

/*
Prediction Result:
(None,)
*/