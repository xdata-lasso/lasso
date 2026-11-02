-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'USD');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201203', 100.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201203', 100.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201203', 50.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201208', 180.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201103', 999.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201303', 888.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Consumption) FROM yearmonth WHERE SUBSTRING(Date, 1, 4) = '2012' GROUP BY SUBSTRING(Date, 5, 2) ORDER BY SUM(Consumption) DESC LIMIT 1;

/*
Gold Result:
(251.0,)
*/

-- Prediction Query
SELECT MAX("consumption") FROM "yearmonth" WHERE "date" LIKE '2012%';

/*
Prediction Result:
(180.0,)
*/