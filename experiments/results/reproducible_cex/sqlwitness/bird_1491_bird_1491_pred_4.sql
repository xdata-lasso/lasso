-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 0, 'Value for money', 'default2'), (2, NULL, NULL, NULL), (1, 2, NULL, 'Value for money'), (3, 0, 'default1', NULL), (4, 0, 'default2', 'Value for money'), (5, 1, 'default2', NULL), (6, 0, 'default2', 'default1'), (7, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Country, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country ORDER BY COUNT(GasStationID) DESC, Country NULLS LAST, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') NULLS LAST LIMIT 1;

/*
Gold Result:
('default2', 2)
*/

-- Prediction Query
SELECT Country, COUNT(*) AS num_value_for_money_stations FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country;

/*
Prediction Result:
(None, 1)
('default2', 1)
*/