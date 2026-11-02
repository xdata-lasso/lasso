-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO products (ProductID, Description) VALUES (1, 'Tie_A_First');
INSERT INTO products (ProductID, Description) VALUES (2, 'Tie_A_Second');
INSERT INTO products (ProductID, Description) VALUES (3, 'Top_Amount');
INSERT INTO products (ProductID, Description) VALUES (4, 'Cutoff_Tie_Included');
INSERT INTO products (ProductID, Description) VALUES (5, 'Cutoff_Tie_Included_2');
INSERT INTO products (ProductID, Description) VALUES (6, 'Cutoff_Tie_Excluded');
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (5, 3, 1000, 1.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (15, 2, 500, 2.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (10, 1, 500, 3.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (20, 4, 300, 4.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (25, 5, 300, 5.0);
INSERT INTO transactions_1k (TransactionID, ProductID, Amount, Price) VALUES (30, 6, 300, 6.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('Top_Amount',)
('Tie_A_First',)
('Tie_A_Second',)
('Cutoff_Tie_Included',)
('Cutoff_Tie_Included_2',)
*/

-- Prediction Query
SELECT P.Description FROM transactions_1k AS T INNER JOIN products AS P ON T.ProductID = P.ProductID GROUP BY T.ProductID ORDER BY SUM(T.Amount) DESC, P.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('Top_Amount',)
('Tie_A_First',)
('Tie_A_Second',)
('Cutoff_Tie_Excluded',)
('Cutoff_Tie_Included',)
*/