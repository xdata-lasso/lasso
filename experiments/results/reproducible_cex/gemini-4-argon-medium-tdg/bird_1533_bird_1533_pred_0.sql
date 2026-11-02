-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, exact boundary on division (Price/Amount = 29.00), wrong ProductID, and wrong Date.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'EUR');
INSERT INTO products (ProductID, Description) VALUES (5, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (6, 'Gasoline');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201208', 100.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201208', 200.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201208', 300.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201209', 400.5);
-- Positive match: 60.0 / 2 = 30.0 > 29.00, ProductID = 5, Date = '201208'
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-15', '12:00:00', 1, 10, 100, 5, 2, 60.0);
-- Boundary mutant killer (>= 29.00 vs > 29.00): 58.0 / 2 = 29.00
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-15', '12:05:00', 2, 20, 100, 5, 2, 58.0);
-- Wrong ProductID mutant killer: 60.0 / 2 = 30.0 > 29.00, ProductID = 6
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-15', '12:10:00', 3, 30, 100, 6, 2, 60.0);
-- Wrong Date mutant killer: 60.0 / 2 = 30.0 > 29.00, ProductID = 5, but T2.Date = '201209'
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-15', '12:15:00', 4, 40, 100, 5, 2, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Price / T1.Amount > 29.00 AND T1.ProductID = 5 AND T2.Date = '201208';

/*
Gold Result:
(100.5,)
*/

-- Prediction Query
SELECT T3.CustomerID, T3.Consumption FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T2.ProductID = 5 AND T1.Price / T1.Amount > 29.00 AND T3.Date LIKE '201208%';

/*
Prediction Result:
(1, 100.5)
*/