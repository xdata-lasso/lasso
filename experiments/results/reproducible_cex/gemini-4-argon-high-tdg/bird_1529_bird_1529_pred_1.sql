-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (38508, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (38509, 'KAM', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 2, 'CZE', 'Premium');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (2, 'Natural 95');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (38508, '201201', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (38508, '201202', 600.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (38508, '201203', 700.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (38509, '201201', 800.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-05-01', '10:00:00', 38508, 101, 10, 1, 2, 15.5);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-01-01', '11:30:00', 38508, 101, 10, 1, 3, 15.5);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '201201', '14:15:00', 38508, 102, 20, 2, 5, 40.25);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '201201', '16:00:00', 38508, 102, 999, 1, 10, 100.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '201201', '09:00:00', 38509, 201, 20, 1, 1, 99.9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Price), SUM(IIF(T3.Date = '201201', T1.Price, 0)) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.CustomerID = '38508';

/*
Gold Result:
(213.75, 71.25)
*/

-- Prediction Query
SELECT SUM(amount * price) AS totalamountspent, SUM(CASE WHEN STRFTIME('%Y%m', date) = '201201' THEN amount * price ELSE 0 END) AS january2012amountspent FROM transactions_1k WHERE customerid = 38508;

/*
Prediction Result:
(1278.75, 46.5)
*/