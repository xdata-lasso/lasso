-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'EUR');
INSERT INTO products (ProductID, Description) VALUES (10, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (20, 'Premium Fuel');
INSERT INTO products (ProductID, Description) VALUES (30, 'Premium Fuel');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201309', 300.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201308', 250.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201309', 450.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '08:00:00', 1, 50, 5, 10, 10, 300.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '09:00:00', 1, 50, 5, 10, 15, 450.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '10:00:00', 2, 60, 6, 10, 20, 600.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-26', '11:00:00', 1, 50, 5, 20, 5, 200.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '2012-08-26', '11:30:00', 1, 50, 5, 30, 8, 320.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('Diesel',)
('Diesel',)
('Diesel',)
('Premium Fuel',)
('Premium Fuel',)
*/

-- Prediction Query
SELECT DISTINCT T3.Description FROM yearmonth AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T2.ProductID = T3.ProductID WHERE SUBSTRING(T1.Date, 1, 6) = '201309';

/*
Prediction Result:
('Diesel',)
('Premium Fuel',)
*/