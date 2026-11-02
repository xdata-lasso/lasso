-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering on Currency = 'EUR', grouping by year (SUBSTRING(Date, 1, 4)) vs full Date, and SUM vs MAX/AVG/COUNT.
-- Year 2012 has two smaller transactions across different months that sum to 160.0 (beating 2013's single 150.0 transaction).
-- Non-EUR customer has huge consumption in 2011 to catch missing WHERE filters.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'LAM', NULL);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 80.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201202', 80.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 150.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201302', -20.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201101', 999.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201001', 888.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('2012',)
*/

-- Prediction Query
SELECT STRFTIME('%Y', "transactions_1k"."Date") AS year, SUM("transactions_1k"."Amount") AS total_gas_use FROM "transactions_1k" INNER JOIN "customers" ON "transactions_1k"."CustomerID" = "customers"."CustomerID" WHERE "customers"."Currency" = 'EUR' GROUP BY year ORDER BY total_gas_use DESC, year NULLS LAST LIMIT 1;

/*
Prediction Result:
*/