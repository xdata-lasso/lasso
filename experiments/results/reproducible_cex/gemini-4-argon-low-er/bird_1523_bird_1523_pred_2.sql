-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gasstations (GasStationID, Country) VALUES (1, 'CZ');
INSERT INTO transactions_1k (TransactionID, CardID, GasStationID) VALUES (1, 667467, 1);
INSERT INTO transactions_1k (TransactionID, CardID, GasStationID) VALUES (2, 667467, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
('CZ',)
('CZ',)
*/

-- Prediction Query
SELECT DISTINCT "gasstations"."country" FROM "transactions_1k" INNER JOIN "gasstations" ON "transactions_1k"."gasstationid" = "gasstations"."gasstationid" WHERE "transactions_1k"."cardid" = 667467;

/*
Prediction Result:
('CZ',)
*/