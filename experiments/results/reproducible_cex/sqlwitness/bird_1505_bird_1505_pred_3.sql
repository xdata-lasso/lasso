-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (999, 'default2', 'EUR'), (1001, 'EUR', 'euro'), (0, NULL, 'default1'), (1000, 'default1', 'EUR'), (1, 'default1', 'default1'), (2, 'EUR', 'default2'), (3, NULL, 'default2'), (4, 'euro', 'default2'), (5, 'EUR', 'EUR'), (6, 'default2', NULL), (7, 'default1', 'euro');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, 'euro', 1001.0), (5, 'EUR', 999.0), (999, 'default1', 999.0), (999, 'default2', NULL), (1000, 'default1', 1001.0), (1, 'default2', 1000.0), (7, 'default2', 999.0), (1000, 'EUR', 0.0), (2, 'default2', 999.0), (1, 'EUR', NULL), (999, 'EUR', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' AND T1.Consumption > 1000.00;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'euro' AND T2.Consumption > 1000;

/*
Prediction Result:
(0,)
*/