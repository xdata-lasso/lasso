-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gasstations (GasStationID, Country) VALUES (1, 'A');
INSERT INTO gasstations (GasStationID, Country) VALUES (2, 'B');
INSERT INTO transactions_1k (TransactionID, GasStationID, ProductID, Price) VALUES (1, 1, 2, 10.0);
INSERT INTO transactions_1k (TransactionID, GasStationID, ProductID, Price) VALUES (2, 2, 2, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT DISTINCT gs.country FROM gasstations AS gs INNER JOIN transactions_1k AS t ON gs.gasstationid = t.gasstationid WHERE t.productid = 2 AND t.price = (SELECT MAX(price) FROM transactions_1k WHERE productid = 2);

/*
Prediction Result:
('A',)
('B',)
*/