-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'kam', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM ', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'KAMM', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201305', 75.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '2013-05', 110.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '20130501', 220.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201305', 330.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201305', 440.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201305', 550.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201305' AND T1.Segment = 'KAM';

/*
Gold Result:
(75.5,)
*/

-- Prediction Query
SELECT SUM(yearmonth.Consumption) FROM yearmonth INNER JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE yearmonth."Date" LIKE '201305%' AND customers.Segment = 'KAM';

/*
Prediction Result:
(295.5,)
*/