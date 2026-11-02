-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Grouping by SUBSTRING(Date, 1, 4) vs grouping by full Date; SUM(Consumption) vs MAX(Consumption) or COUNT(*); WHERE Currency = 'EUR' vs omitting filter or including NULLs.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', NULL);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201101', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201001', 600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('2012',)
*/

-- Prediction Query
SELECT STRFTIME('%Y', T1.Date) FROM (SELECT t.Date, SUM(t.Amount) AS total_amount FROM transactions_1k AS t JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'EUR' GROUP BY STRFTIME('%Y', t.Date)) AS T1 ORDER BY T1.total_amount DESC, STRFTIME('%Y', T1.Date) NULLS LAST LIMIT 1;

/*
Prediction Result:
*/