-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- String matching mutations (case sensitivity, substring/LIKE, leading/trailing spaces) and NULL consumption
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (10, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (11, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (12, 'kam', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (13, 'KAMM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (14, ' KAM ', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '201305', 50.25);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (11, '201305', NULL);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (12, '201305', 75.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (13, '201305', 80.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (14, '201305', 90.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '2013050', 110.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, ' 201305', 120.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201305' AND T1.Segment = 'KAM';

/*
Gold Result:
(50.25,)
*/

-- Prediction Query
SELECT SUM(yearmonth.Consumption) FROM yearmonth INNER JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE yearmonth."Date" LIKE '201305%' AND customers.Segment = 'KAM';

/*
Prediction Result:
(160.25,)
*/