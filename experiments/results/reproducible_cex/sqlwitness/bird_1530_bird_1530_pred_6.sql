-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-01', NULL, 5, 1, 1, 6, 4, 1.0), (4, '2023-01-02', 'default1', 5, 1, NULL, 0, 1, NULL), (5, NULL, 'default1', 1, 6, 6, NULL, 0, 1.0), (0, '2023-01-01', 'default1', NULL, 4, 5, 1, 6, NULL), (6, NULL, 'default1', 4, 6, 5, 1, NULL, 6.0), (2, NULL, NULL, 6, 0, NULL, 0, NULL, 1.0), (3, '2023-01-01', 'default2', 1, NULL, 5, 6, 5, 0.0), (7, '2023-01-02', 'default2', 5, 6, 5, 1, 0, NULL), (8, '2023-01-01', 'default2', 0, NULL, 6, NULL, 5, 0.0), (9, '2023-01-02', NULL, 4, 5, 1, 4, 4, 6.0), (10, '2023-01-02', 'default1', NULL, 0, 6, 4, 1, 5.0), (11, NULL, 'default2', 6, 4, NULL, 1, 6, 6.0), (12, '2023-01-01', 'default2', 4, NULL, NULL, NULL, 5, 6.0);
INSERT INTO products (productid, description) VALUES (1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('default2',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT p.Description FROM transactions_1k AS t INNER JOIN products AS p ON t.ProductID = p.ProductID GROUP BY p.ProductID, p.Description ORDER BY SUM(t.Amount) DESC, p.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('default2',)
*/