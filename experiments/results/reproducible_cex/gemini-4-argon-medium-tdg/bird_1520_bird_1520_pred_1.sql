-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match and single-condition boundary failures (kills mutants with wrong WHERE predicates, OR instead of AND, or missing conditions).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 500.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 600.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201', 700.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201202', 800.0);
-- Exact match on all conditions
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '10:00:00', 1, 10, 100, 1, 10, 124.05);
-- Fails T1.Date condition
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '10:00:00', 2, 11, 100, 1, 10, 124.05);
-- Fails T1.Price condition (boundary value)
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-24', '10:00:00', 3, 12, 100, 1, 10, 124.00);
-- Fails T2.Date condition (via CustomerID 4)
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-24', '10:00:00', 4, 13, 100, 1, 10, 124.05);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID, T2.Date, T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Price = 124.05 AND T2.Date = '201201';

/*
Gold Result:
(1, '201201', 500.5)
*/

-- Prediction Query
SELECT SUM(y.Consumption) AS TotalExpense, y.Date AS Date, t.Amount AS Expense FROM transactions_1k AS t INNER JOIN yearmonth AS y ON t.CustomerID = y.CustomerID WHERE t.Amount = 124.05 AND t.Date = '2012-08-24' AND y."Date" LIKE '2012-01-%';

/*
Prediction Result:
(None, None, None)
*/