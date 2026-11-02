-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, exact boundary conditions on Date and Consumption, AND vs OR logic, and column projection (Segment vs Currency).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'GBP');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'KAM', 'JPY');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (6, 'LAM', 'AUD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (7, 'SME', 'CAD');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201306', 214582.17);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201305', 214582.17);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201307', 214582.17);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201306', 214582.16);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201306', 214582.18);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (6, '201306', 214582.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (7, '201306', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Currency FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201306' AND T1.Consumption = 214582.17;

/*
Gold Result:
('EUR',)
*/

-- Prediction Query
SELECT c.Currency FROM yearmonth AS y JOIN customers AS c ON y.CustomerID = c.CustomerID WHERE y."Date" LIKE '201306%' GROUP BY y.CustomerID HAVING SUM(y.Consumption) > 214582.17;

/*
Prediction Result:
('JPY',)
*/