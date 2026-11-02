-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1001, 'purpose', 'face');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1002, 'brother', 'election');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1003, 'ago', 'dog');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1004, 'site', 'chair');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1005, '1970-01-01', 'since', 1001, 1009, 1013, 1017, 1021, 1025.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1006, '1970-01-02', 'blue', 1002, 1020.0, 1026.0, 1032.0, 1038.0, 1044.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1007, '1970-01-03', 'require', 1003, 1031.0, 1039.0, 1047.0, 1055.0, 1063.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1008, '1970-01-04', 'sit', 1004, 1042.0, 1052.0, 1062.0, 1072.0, 1082.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
('purpose',)
*/

-- Prediction Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY T2.Date, T1.customerid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/