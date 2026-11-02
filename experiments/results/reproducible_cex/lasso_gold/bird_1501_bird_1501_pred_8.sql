-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1037, 'early', 'mouth');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1047, NULL, NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1038, 1039, 'Netherlands', 'agreement');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1048, 1039, 'Netherlands', 'agreement');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1040, '1974-05-05', 'option', 1037, 1041, 1038, 1042, 1043, 1044.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1046, '1974-05-05', 'option', 1047, 1041, 1048, 1042, 1043, 1044.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1037, '201306', 1045.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1047, '201306', 1045.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('Netherlands',)
('Netherlands',)
*/

-- Prediction Query
SELECT DISTINCT T3.Country FROM yearmonth AS T1 JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID JOIN gasstations AS T3 ON T2.GasStationID = T3.GasStationID WHERE T1."Date" LIKE '201306%';

/*
Prediction Result:
('Netherlands',)
*/