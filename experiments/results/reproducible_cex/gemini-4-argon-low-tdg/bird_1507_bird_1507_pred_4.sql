-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (multiple transactions at same time for ChainID = 11, both within same station and across different stations).
-- 2. Boundary conditions for ChainID = 11 (ChainID = 10, 12, NULL).
-- 3. Wrong column used for ChainID filter (e.g., GasStationID = 11, CustomerID = 11, ProductID = 11, TransactionID = 11).
-- 4. Missing JOIN condition (Cartesian product check).
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 11, 'CZE', 'Value');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 11, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 10, 'SVK', 'Value');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (4, 12, 'SVK', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (5, NULL, 'CZE', 'Other');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (11, 99, 'CZE', 'Value');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2023-01-01', '08:00:00', 101, 201, 1, 301, 10, 20.5);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2023-01-01', '08:00:00', 102, 202, 1, 302, 15, 30.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2023-01-02', '08:00:00', 103, 203, 2, 301, 20, 40.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2023-01-02', '09:30:00', 104, 204, 2, 303, 5, 10.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '2023-01-03', '10:15:00', 105, 205, 3, 301, 12, 25.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (6, '2023-01-03', '11:45:00', 106, 206, 4, 302, 8, 16.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (7, '2023-01-04', '12:00:00', 107, 207, 5, 301, 25, 50.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (11, '2023-01-05', '13:00:00', 11, 11, 11, 11, 11, 11.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.Time FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.ChainID = 11;

/*
Gold Result:
('08:00:00',)
('09:30:00',)
*/

-- Prediction Query
SELECT T2.Time FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ChainID = 11;

/*
Prediction Result:
('08:00:00',)
('08:00:00',)
('08:00:00',)
('09:30:00',)
*/