-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1001, 'purpose', 'brother');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1002, 1003, 'Anguilla', 'site');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1004, '1970-01-01', 'face', 1001, 1005, 1002, 1006, 1007, 1008.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1001, '201306', 1009.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('Anguilla',)
*/

-- Prediction Query
SELECT DISTINCT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE STRFTIME('%Y%m', T1.Date) = '201306';

/*
Prediction Result:
*/