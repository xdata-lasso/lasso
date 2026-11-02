-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Floating-point division (1/3 = 33.3333%) vs integer division (33 or 0).
-- 2. COUNT(T1.CustomerID) vs COUNT(DISTINCT T1.CustomerID) (Customer 1 has 2 transactions, Customer 2 has 1; distinct would give 1/2 = 50% instead of 1/3).
-- 3. JOIN vs subquery without join (Customer 3 has EUR, Customer 4 has CZK, neither has transactions on target date).
-- 4. Date filter boundary ('2012-08-24', '2012-08-25', '2012-08-26').
-- 5. Orphan transaction (CustomerID 999 not in customers) to kill LEFT JOIN mutants.
-- 6. NULL Currency handling.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'KAM', NULL);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '10:00:00', 1, 101, 1, 1, 10, 100.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '11:00:00', 1, 101, 1, 1, 20, 200.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '12:00:00', 2, 102, 1, 1, 15, 150.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-24', '12:00:00', 3, 103, 1, 1, 15, 150.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '2012-08-26', '12:00:00', 3, 103, 1, 1, 15, 150.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (6, '2012-08-25', '13:00:00', 999, 104, 1, 1, 15, 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT t.CustomerID) AS REAL) * 100.0 / CAST((SELECT COUNT(DISTINCT CustomerID) FROM customers) AS REAL)) AS percentage FROM transactions_1k AS t JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'EUR' AND t.Date = '2012-08-25';

/*
Prediction Result:
(20.0,)
*/