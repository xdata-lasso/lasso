-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (101, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (102, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (103, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (104, 'LAM', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (105, 'SME', NULL);
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (201, 30, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (202, 30, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (203, 10, 'SVK', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (204, 50, 'CZE', 'Premium');
INSERT INTO products (ProductID, Description) VALUES (401, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (402, 'Natural 95');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (101, '201208', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (102, '201208', 1200.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (103, '201208', 800.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '09:30:00', 101, 501, 201, 401, 40, 1500.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-24', '10:15:00', 101, 501, 201, 401, 20, 750.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '11:00:00', 102, 502, 202, 402, 35, 1400.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-25', '14:20:00', 102, 503, 203, 401, 50, 1900.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '2012-08-26', '08:00:00', 103, 504, 204, 401, 60, 2200.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (6, '2012-08-26', '16:45:00', 104, 505, 204, 402, 25, 950.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (7, '2012-08-27', '12:10:00', 105, 506, 204, 401, 30, 1100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.ChainID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.Currency = 'EUR';

/*
Gold Result:
(30,)
(10,)
*/

-- Prediction Query
SELECT DISTINCT T3.ChainID FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T2.GasStationID = T3.GasStationID WHERE T1.Currency = 'Euro';

/*
Prediction Result:
*/