-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', 'default2', NULL, 4, 1, 0, 6, 5.0), (6, NULL, 'default1', NULL, 1, 0, 4, 5, 0.0), (1, '2023-01-01', 'default1', 1, 1, 1, 1, 6, 1.0), (5, '2023-01-01', NULL, NULL, NULL, 1, 4, 6, 4.0), (4, NULL, 'default2', 4, 0, 1, 1, 0, NULL), (2, '2023-01-01', NULL, 6, 5, 5, NULL, 1, 1.0), (3, '2023-01-02', 'default1', 0, 0, 4, 5, NULL, 0.0), (7, '2023-01-02', 'default1', 0, 6, NULL, 1, 0, 4.0);
INSERT INTO products (productid, description) VALUES (0, NULL), (5, 'default2'), (1, NULL), (4, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
(None,)
(None,)
('default2',)
('default2',)
(None,)
*/

-- Prediction Query
SELECT P.Description FROM transactions_1k AS T INNER JOIN products AS P ON T.ProductID = P.ProductID GROUP BY T.ProductID ORDER BY SUM(T.Amount) DESC, P.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('default2',)
(None,)
(None,)
('default2',)
*/