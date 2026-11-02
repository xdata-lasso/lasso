-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (8, NULL, 'default1', 0, NULL, 1, 8, 8, 1.0), (2, '2023-01-02', 'default1', 0, NULL, 1, 8, 6, 1.0), (6, '2023-01-02', '2013-06', 2, 8, 6, 8, 7, 2.0), (7, '2013-06-27', NULL, 8, 7, 0, 0, 8, 1.0), (1, '2023-01-02', 'default1', 6, 8, 7, NULL, 7, 6.0), (0, NULL, 'default2', 6, 2, NULL, 0, 6, 7.0), (3, '2023-01-01', NULL, 0, 0, NULL, 7, 0, 6.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (8, NULL, 'default1', 'default1'), (0, 0, '201306', 'default2'), (7, 0, NULL, NULL), (6, 8, 'default1', 'default1'), (1, NULL, '201306', 'default2'), (2, 7, 'default2', '201306'), (3, 6, 'default1', 'default2'), (4, 7, 'default2', NULL), (5, 8, 'default1', 'default2');
INSERT INTO customers (customerid, segment, currency) VALUES (7, '2013-06', 'default1'), (8, '2013-06', 'default1'), (6, '201306', 'default2'), (2, 'default2', '2013-06'), (1, 'default2', 'default2'), (0, NULL, 'default2'), (3, NULL, 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, '2013-06', 8.0), (7, '201306', NULL), (1, 'default2', 1.0), (8, 'default1', 2.0), (3, '201306', 6.0), (7, '2013-06', 6.0), (0, 'default2', 7.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT "g"."country" FROM "transactions_1k" AS "t" INNER JOIN "gasstations" AS "g" ON "t"."gasstationid" = "g"."gasstationid" WHERE SUBSTRING("t"."date", 1, 7) = '2013-06';

/*
Prediction Result:
('201306',)
*/