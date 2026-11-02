-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 10, 'CZE', 'Value');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 10, 'SVK', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 20, 'GER', 'Value');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (2, 'Gasoline');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2023-01-01', '10:00', 100, 1000, 1, 2, 50, 20.5);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2023-01-01', '11:00', 101, 1001, 2, 2, 10, 45.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2023-01-01', '12:00', 102, 1002, 3, 1, 100, 999.9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('SVK',)
*/

-- Prediction Query
SELECT g.Country FROM transactions_1k AS t INNER JOIN gasstations AS g ON t.GasStationID = g.GasStationID WHERE t.ProductID = 2 AND t.Amount = 1 ORDER BY t.Price DESC, t.transactionid NULLS LAST, g.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/