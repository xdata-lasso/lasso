-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, NULL, 'EUR'), (0, 'default2', 'Euro'), (1001, 'default1', 'EUR'), (999, 'EUR', 'Euro'), (1000, 'default2', 'default2'), (2, 'default1', 'Euro'), (3, 'default1', 'Euro'), (4, NULL, 'EUR'), (5, NULL, 'Euro'), (6, NULL, 'EUR'), (7, 'EUR', 'Euro'), (8, NULL, 'default1'), (9, 'default2', 'default2'), (10, 'default2', 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (4, 'default2', 1.0), (5, 'EUR', 999.0), (6, 'default2', 1000.0), (4, 'default1', 1001.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' AND T1.Consumption > 1000.00;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'Euro' AND T2.Consumption > 1000;

/*
Prediction Result:
(0,)
*/