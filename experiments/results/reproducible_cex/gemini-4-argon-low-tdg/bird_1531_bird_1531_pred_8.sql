-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic subquery selection (single max Consumption) and differentiates SUM(Price / Amount) from SUM(Price) / SUM(Amount) and AVG(Price / Amount).
-- Also includes a customer with higher total consumption across multiple months to kill mutants that group/sum in the subquery.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'CZK');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 300.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201202', 300.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-01-01', '10:00:00', 1, 101, 1, 1, 2, 10.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-01-02', '11:00:00', 1, 101, 1, 1, 10, 100.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-01-03', '12:00:00', 2, 102, 1, 1, 5, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Price / T2.Amount), T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.CustomerID = (SELECT CustomerID FROM yearmonth ORDER BY Consumption DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1) GROUP BY T2.CustomerID, T1.Currency;

/*
Gold Result:
(1, 15.0, 'EUR')
*/

-- Prediction Query
SELECT t1.CustomerID, AVG(t1.Price / t1.Amount) AS average_price, t2.Currency FROM transactions_1k AS t1 JOIN customers AS t2 ON t1.CustomerID = t2.CustomerID GROUP BY t1.CustomerID ORDER BY SUM(t1.Price) DESC, t1.CustomerID NULLS LAST, average_price NULLS LAST, t2.Currency NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 7.5, 'EUR')
*/