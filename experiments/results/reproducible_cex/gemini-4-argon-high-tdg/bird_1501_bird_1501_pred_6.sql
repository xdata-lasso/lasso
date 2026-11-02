-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (101, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (102, 'LAM', 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (201, 1, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (202, 2, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (203, 3, 'SVK', 'Discount');
INSERT INTO products (ProductID, Description) VALUES (301, 'Diesel');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (101, '201306', 1250.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (102, '201306', 840.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '09:15:00', 101, 501, 201, 301, 10, 350.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '10:20:00', 101, 501, 201, 301, 20, 700.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-26', '11:30:00', 101, 502, 202, 301, 15, 525.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-27', '14:45:00', 102, 503, 203, 301, 30, 1050.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('CZE',)
('CZE',)
('CZE',)
('SVK',)
*/

-- Prediction Query
SELECT DISTINCT g.Country FROM yearmonth AS y JOIN gasstations AS g ON y.CustomerID = g.GasStationID WHERE y.Date LIKE '201306%';

/*
Prediction Result:
*/