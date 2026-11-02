-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1010, 1012, 'CZE', 'Discount');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1011, 1017.0, 'SVK', 'Discount');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1014, 1012, 'CZE', 'Discount');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(Country = 'CZE', 1, 0)) - SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations WHERE Segment = 'Discount';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT (SELECT COUNT(GasStationID) FROM gasstations WHERE Country = 'Czech Republic' AND Segment = 'discount') - (SELECT COUNT(GasStationID) FROM gasstations WHERE Country = 'Slovakia' AND Segment = 'discount') AS Difference;

/*
Prediction Result:
(0,)
*/