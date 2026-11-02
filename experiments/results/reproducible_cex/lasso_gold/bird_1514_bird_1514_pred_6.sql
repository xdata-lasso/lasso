-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1113, 'surface', 'animal');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1122, 'surface', 'animal');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1114, 1115, 'Saint Lucia', 'machine');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1123, 1115, 'Saint Lucia', 'machine');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1116, '2012-08-24', '16:25:00', 1113, 1117, 1114, 1118, 1119, 1120.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1121, '2012-08-24', '16:25:00', 1122, 1117, 1123, 1118, 1119, 1120.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
('animal',)
('animal',)
*/

-- Prediction Query
SELECT DISTINCT customers.currency FROM transactions_1k INNER JOIN customers ON transactions_1k.customerid = customers.customerid WHERE transactions_1k.date = '2012-08-24' AND transactions_1k.time = '16:25:00';

/*
Prediction Result:
('animal',)
*/