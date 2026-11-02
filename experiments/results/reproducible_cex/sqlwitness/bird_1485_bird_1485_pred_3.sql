-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (8, 'default1', 'default1'), (0, '201304', 'default2'), (-1, NULL, '201304'), (201305, NULL, 'default1'), (1, NULL, '201304'), (201304, '201304', '201304'), (201303, '201304', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (201303, 'default1', 0.0), (201304, 'default1', 4.0), (201305, '201304', 4.0), (1, 'default2', 6.0), (8, 'default1', 0.0), (8, '201304', 5.0), (0, 'default2', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(CustomerID = 7, Consumption, 0)) - SUM(IIF(CustomerID = 5, Consumption, 0)) FROM yearmonth WHERE Date = '201304';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT CAST((SELECT Consumption FROM yearmonth WHERE CustomerID = 7 AND Date = 201304) AS REAL) - CAST((SELECT Consumption FROM yearmonth WHERE CustomerID = 5 AND Date = 201304) AS REAL) AS ConsumptionDifference;

/*
Prediction Result:
(None,)
*/