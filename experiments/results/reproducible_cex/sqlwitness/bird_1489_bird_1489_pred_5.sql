-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'KAM', NULL), (0, '201305', 'KAM'), (2, '201305%', NULL), (3, 'KAM', 'default1'), (4, 'default2', 'default2'), (5, 'KAM', '201305%'), (6, 'default1', 'KAM'), (7, '201305%', '201305%'), (8, NULL, 'KAM');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (2, 'default2', NULL), (8, 'default2', 1.0), (4, 'default1', NULL), (1, '201305%', 1.0), (5, 'default2', 1.0), (2, 'default1', 0.0), (1, 'default2', 1.0), (8, 'KAM', 1.0), (3, 'KAM', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date = '201305' AND T1.Segment = 'KAM';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(yearmonth.Consumption) FROM yearmonth INNER JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE yearmonth."Date" LIKE '201305%' AND customers.Segment = 'KAM';

/*
Prediction Result:
(1.0,)
*/