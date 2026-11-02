-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'KAM', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'KAM', NULL);
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 100, 'DEU', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 200, 'AUT', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (30, 300, 'CZE', 'Discount');
INSERT INTO products (ProductID, Description) VALUES (101, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (102, 'Natural 95');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1001, '2012-08-24', '09:30:00', 1, 501, 10, 101, 5, 10.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1002, '2012-08-24', '10:15:00', 1, 502, 20, 102, 8, 10.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1003, '2012-08-25', '14:20:00', 2, 503, 20, 101, 12, 25.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1004, '2012-08-25', '16:00:00', 3, 504, 30, 101, 20, 100.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1005, '2012-08-26', '11:45:00', 4, 505, 10, 102, 15, 200.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1006, '2012-08-26', '18:10:00', 5, 506, 10, 101, 10, 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(15.0,)
*/

-- Prediction Query
SELECT AVG(CAST(t.Amount * t.Price AS REAL)) AS average_total_price FROM transactions_1k AS t JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'EUR';

/*
Prediction Result:
(143.33333333333334,)
*/