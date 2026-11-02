-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, NULL, 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'KAM');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 60.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202', 60.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201203', 30.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201202', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201201', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201201', 900.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-01-15', '10:00:00', 2, 1001, 10, 100, 500, 999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' GROUP BY T2.CustomerID ORDER BY SUM(T2.Consumption) DESC, T2.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1, 151.0)
*/

-- Prediction Query
SELECT CustomerID, MAX(Consumption) AS MaxConsumption FROM yearmonth WHERE CustomerID IN (SELECT CustomerID FROM customers WHERE Segment = 'KAM') GROUP BY CustomerID ORDER BY MaxConsumption DESC, CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
(2, 100.0)
*/