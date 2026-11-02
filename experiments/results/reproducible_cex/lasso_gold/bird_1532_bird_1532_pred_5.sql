-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1001, 1005, 'Northern Mariana Islands', 'face');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1002, 1010.0, 'Bouvet Island (Bouvetoya)', 'election');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1003, 1015.0, 'Anguilla', 'dog');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1004, 1020.0, 'Saint Vincent and the Grenadines', 'chair');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1009, '1970-01-01', 'since', 1013, 1017, 1001, 2, 1021, 1025.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1010, '1970-01-02', 'blue', 1022.0, 1028.0, 1002, 2, 1038.0, 1044.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1011, '1970-01-03', 'require', 1031.0, 1039.0, 1003, 2, 1055.0, 1063.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1012, '1970-01-04', 'sit', 1040.0, 1050.0, 1004, 2, 1072.0, 1082.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('Saint Vincent and the Grenadines',)
*/

-- Prediction Query
SELECT T3.Country FROM transactions_1k AS T1 JOIN products AS T2 ON T1.ProductID = T2.ProductID JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST, T3.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/