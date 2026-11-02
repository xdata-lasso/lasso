-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'EUR');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (2, 'Natural 95');
INSERT INTO products (ProductID, Description) VALUES (3, 'Wash');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (101, 1, 'POL', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (102, 2, 'HUN', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (103, 3, 'SVK', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (104, 4, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (105, 5, 'DEU', 'Noname');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '09:00:00', 1, 10, 101, 1, 50, 500.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-24', '10:00:00', 2, 20, 102, 3, 40, 400.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-24', '11:00:00', 1, 10, 103, 2, 10, 99.9);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-24', '12:00:00', 2, 20, 104, 2, 12, 120.5);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '2012-08-24', '13:00:00', 1, 10, 105, 2, 5, 15.2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('CZE',)
*/

-- Prediction Query
SELECT g.Country FROM transactions_1k AS t INNER JOIN gasstations AS g ON t.GasStationID = g.GasStationID WHERE t.ProductID = 2 AND t.Amount = 1 ORDER BY t.Price DESC, t.transactionid NULLS LAST, g.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/