-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, 'default2', 0, 4, 3, 5, 0, 1.0), (2, NULL, '%Y', 2, 3, 5, 2, 2, 1.0), (4, '2023-01-02', 'default2', 3, 2, 3, 4, 5, 2.0);
INSERT INTO customers (customerid, segment, currency) VALUES (1, '%Y', 'default1'), (2, 'default1', 'default2'), (5, 'default1', NULL), (0, '%Y', 'EUR');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (0, 'default1', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('defa',)
*/

-- Prediction Query
SELECT STRFTIME('%Y', T1.Date) FROM (SELECT t.Date, SUM(t.Amount) AS total_amount FROM transactions_1k AS t JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'EUR' GROUP BY STRFTIME('%Y', t.Date)) AS T1 ORDER BY T1.total_amount DESC, STRFTIME('%Y', T1.Date) NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/