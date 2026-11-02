-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'KAM', 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value for money');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2014-05-01', '12:00:00', 1, 1001, 10, 100, 500, 15000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201101', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201102', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201103', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201202', 60.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201301', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201001', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201301', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('2012',)
*/

-- Prediction Query
SELECT STRFTIME('%Y', T2.Date) AS Year FROM yearmonth AS T2 JOIN customers AS T1 ON T2.CustomerID = T1.CustomerID WHERE T1.Currency = 'CZK' GROUP BY Year ORDER BY SUM(T2.Consumption) DESC, Year NULLS LAST LIMIT 1;

/*
Prediction Result:
('-4162',)
*/