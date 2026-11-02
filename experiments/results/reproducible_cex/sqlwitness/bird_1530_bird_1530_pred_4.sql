-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, 'default1', 5, 5, 4, 4, 1, 5.0), (0, NULL, 'default2', 6, 5, 1, 5, NULL, 5.0), (5, '2023-01-01', 'default2', 4, 4, 4, 5, 6, NULL);
INSERT INTO products (productid, description) VALUES (1, NULL), (6, 'default2'), (4, 'default1'), (5, 'default2'), (0, 'default1'), (2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('default2',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT p.Description FROM products AS p JOIN transactions_1k AS t ON p.ProductID = t.ProductID GROUP BY p.ProductID ORDER BY CAST(SUM(t.Amount) AS REAL) DESC, p.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('default2',)
('default1',)
*/