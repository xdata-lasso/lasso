-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO products (ProductID, Description) VALUES (1, 'Prod_1');
INSERT INTO products (ProductID, Description) VALUES (2, 'Prod_2');
INSERT INTO products (ProductID, Description) VALUES (3, 'Prod_3');
INSERT INTO products (ProductID, Description) VALUES (4, 'Prod_4');
INSERT INTO products (ProductID, Description) VALUES (5, 'Prod_5');
INSERT INTO products (ProductID, Description) VALUES (6, 'Prod_6');
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (10, 1, 100, 10.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (20, 2, 200, 20.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (30, 3, 300, 30.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (40, 4, 400, 40.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (50, 5, 500, 50.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (60, 6, 600, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('Prod_6',)
('Prod_5',)
('Prod_4',)
('Prod_3',)
('Prod_2',)
*/

-- Prediction Query
SELECT p.Description FROM transactions_1k AS t JOIN products AS p ON t.ProductID = p.ProductID GROUP BY t.ProductID ORDER BY COUNT(t.TransactionID) DESC, p.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('Prod_1',)
('Prod_2',)
('Prod_3',)
('Prod_4',)
('Prod_5',)
*/