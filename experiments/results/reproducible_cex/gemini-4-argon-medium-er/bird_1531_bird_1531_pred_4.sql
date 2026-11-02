-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '202001', 100.0);
INSERT INTO transactions_1k (TransactionID, CustomerID, Amount, Price) VALUES (1, 1, 1, 10.0);
INSERT INTO transactions_1k (TransactionID, CustomerID, Amount, Price) VALUES (2, 1, 1, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Price / T2.Amount), T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.CustomerID = (SELECT CustomerID FROM yearmonth ORDER BY Consumption DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1) GROUP BY T2.CustomerID, T1.Currency;

/*
Gold Result:
(1, 20.0, 'EUR')
*/

-- Prediction Query
SELECT c.CustomerID, CAST(SUM(t.Price) AS REAL) / SUM(t.Amount) AS average_price_per_item, c.Currency FROM transactions_1k AS t JOIN customers AS c ON t.CustomerID = c.CustomerID GROUP BY c.CustomerID ORDER BY SUM(t.Price) DESC, c.CustomerID NULLS LAST, average_price_per_item NULLS LAST, c.Currency NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 10.0, 'EUR')
*/