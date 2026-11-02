-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (6, NULL, 'default2', NULL, 0, 4, 1, NULL, NULL), (4, '2023-01-01', NULL, 5, 6, NULL, 4, 1, 4.0), (5, NULL, NULL, 6, 4, 6, 6, 6, NULL), (1, NULL, NULL, 6, NULL, 1, 5, 5, 1.0), (0, '2023-01-02', 'default1', 4, 5, 4, 4, NULL, 4.0), (2, NULL, NULL, 4, 1, 4, 4, 5, 1.0), (3, NULL, 'default1', 0, 1, NULL, 0, 1, 1.0), (7, '2023-01-01', 'default2', 0, NULL, 1, 1, 0, 4.0);
INSERT INTO products (productid, description) VALUES (4, 'default2'), (0, NULL), (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
(None,)
('default2',)
(None,)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT p.description FROM products AS p INNER JOIN (SELECT productid, SUM(amount) AS totalsales FROM transactions_1k GROUP BY productid ORDER BY totalsales DESC, productid NULLS LAST LIMIT 5) AS t ON p.productid = t.productid;

/*
Prediction Result:
('default2',)
(None,)
(None,)
*/