-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO products (ProductID, Description) VALUES (10, 'Repeated_Product');
INSERT INTO products (ProductID, Description) VALUES (20, 'Unique_Product');
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (1, 10, 500, 10.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (2, 10, 400, 10.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (3, 10, 300, 10.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (4, 20, 200, 20.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (5, 10, 100, 10.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (6, 20, 50, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('Repeated_Product',)
('Repeated_Product',)
('Repeated_Product',)
('Unique_Product',)
('Repeated_Product',)
*/

-- Prediction Query
SELECT p.description FROM products AS p INNER JOIN (SELECT productid, SUM(amount) AS totalsales FROM transactions_1k GROUP BY productid ORDER BY totalsales DESC, productid NULLS LAST LIMIT 5) AS t ON p.productid = t.productid;

/*
Prediction Result:
('Repeated_Product',)
('Unique_Product',)
*/