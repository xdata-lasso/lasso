-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (10, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (20, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (30, 'LAM', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 10, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 20, 'SVK', 'Premium');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (200, 'Natural 95');
INSERT INTO products (ProductID, Description) VALUES (300, 'Car Wash');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '201308', 500.25);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (20, '201309', 1200.50);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (30, '201310', 800.00);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '201309', '10:00:00', 10, 1001, 1, 100, 20, 600.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-24', '12:30:00', 20, 1002, 2, 200, 45, 1350.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2013-09-15', '14:15:00', 30, 1003, 1, 300, 1, 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('Natural 95',)
*/

-- Prediction Query
SELECT DISTINCT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID WHERE STRFTIME('%Y%m', T1.Date) = '201309';

/*
Prediction Result:
('Car Wash',)
*/