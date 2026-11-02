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
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value for money');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '10:00:00', 1, 111, 10, 100, 30, 634.8);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-26', '11:00:00', 2, 222, 10, 100, 30, 634.8);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '12:00:00', 3, 333, 10, 100, 30, 500.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-25', '13:00:00', 4, 444, 99, 100, 30, 634.8);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 40.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 15.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201302', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201401', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 1000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201', 2000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201201', 3000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(0.75,)
*/

-- Prediction Query
SELECT CASE WHEN SUM(CASE WHEN STRFTIME('%Y', T1.Date) = '2012' THEN T1.Consumption ELSE 0 END) = 0 THEN 0 ELSE (SUM(CASE WHEN STRFTIME('%Y', T1.Date) = '2012' THEN T1.Consumption ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.Date) = '2013' THEN T1.Consumption ELSE 0 END)) * 1.0 / SUM(CASE WHEN STRFTIME('%Y', T1.Date) = '2012' THEN T1.Consumption ELSE 0 END) END FROM yearmonth AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Amount = 634.8 AND T2.Date = '2012-08-25';

/*
Prediction Result:
(None,)
*/