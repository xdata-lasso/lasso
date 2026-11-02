-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'A', 'USD');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201309', 100.0);
INSERT INTO transactions_1k (TransactionID, CustomerID, ProductID) VALUES (1, 1, 1);
INSERT INTO transactions_1k (TransactionID, CustomerID, ProductID) VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('Diesel',)
('Diesel',)
*/

-- Prediction Query
SELECT DISTINCT products.description FROM transactions_1k INNER JOIN products ON transactions_1k.productid = products.productid INNER JOIN yearmonth ON transactions_1k.customerid = yearmonth.customerid WHERE yearmonth.date = '201309';

/*
Prediction Result:
('Diesel',)
*/