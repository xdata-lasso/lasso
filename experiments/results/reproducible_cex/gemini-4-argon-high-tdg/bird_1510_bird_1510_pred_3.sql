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
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 2, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (25, 3, 'CZE', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (30, 10, 'SVK', 'CZE');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (200, 'Natural 95');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201208', 150.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201209', 200.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '09:30:00', 1, 501, 10, 100, 5, 10.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-24', '10:15:00', 1, 501, 10, 200, 8, 10.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '14:00:00', 2, 502, 20, 100, 12, 40.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-26', '16:45:00', 3, 503, 30, 100, 100, 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Gold Result:
(20.0,)
*/

-- Prediction Query
SELECT AVG(T2.Amount * T2.Price) FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Country = 'CZE';

/*
Prediction Result:
(203.33333333333334,)
*/