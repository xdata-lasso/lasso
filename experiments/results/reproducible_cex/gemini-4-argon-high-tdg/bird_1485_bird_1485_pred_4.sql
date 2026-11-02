-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (7, 'SME', 'CZK');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (7, '201304', 85.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201303', 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(CustomerID = 7, Consumption, 0)) - SUM(IIF(CustomerID = 5, Consumption, 0)) FROM yearmonth WHERE Date = '201304';

/*
Gold Result:
(85.0,)
*/

-- Prediction Query
SELECT T1.Consumption - T2.Consumption FROM yearmonth AS T1 INNER JOIN yearmonth AS T2 ON T1.Date = T2.Date WHERE T1.CustomerID = 7 AND T2.CustomerID = 5 AND T1.Date = '201304';

/*
Prediction Result:
*/