-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 10, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 20, 'SVK', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 30, 'DEU', 'Discount');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '10:00:00', 100, 1000, 1, 1, 25, 548.4);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-24', '11:00:00', 101, 1001, 2, 1, 20, 500.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '12:00:00', 102, 1002, 3, 1, 25, 548.4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
('CZE',)
*/

-- Prediction Query
SELECT DISTINCT customers.segment FROM customers INNER JOIN transactions_1k ON customers.customerid = transactions_1k.customerid WHERE STRFTIME('%Y-%m-%d', transactions_1k.date) = '2012-08-24' AND transactions_1k.price = 548.4;

/*
Prediction Result:
*/