-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (2, NULL, '%Y'), (1, 'default1', 'default1'), (4, NULL, 'default1'), (5, 'default1', NULL), (0, 'EUR', 'EUR'), (3, '%Y', '%Y'), (6, 'default2', 'default2'), (7, 'EUR', 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, '%Y', 4.0), (5, 'EUR', 0.0), (2, 'default2', NULL), (0, 'default1', 0.0), (4, 'default2', 0.0), (0, 'EUR', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('defa',)
*/

-- Prediction Query
SELECT STRFTIME('%Y', T2.Date) AS Year FROM yearmonth AS T2 JOIN customers AS T1 ON T2.CustomerID = T1.CustomerID WHERE T1.Currency = 'EUR' GROUP BY Year ORDER BY SUM(T2.Consumption) DESC, Year NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/