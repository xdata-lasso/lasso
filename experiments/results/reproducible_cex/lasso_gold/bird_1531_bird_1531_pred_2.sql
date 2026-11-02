-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (0, 'purpose', 'face');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1001, 'brother', 'face');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1002, 'ago', 'face');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1003, 'site', 'face');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1004, '1970-01-01', 'election', 0, 1008, 1012, 1016, 1020, 1024.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1005, '1970-01-02', 'dog', 0, 1019.0, 1025.0, 1031.0, 1037.0, 1043.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1006, '1970-01-03', 'chair', 0, 1030.0, 1038.0, 1046.0, 1054.0, 1062.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1007, '1970-01-04', 'since', 0, 1041.0, 1051.0, 1061.0, 1071.0, 1081.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'blue', 1028.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'require', 1035.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'sit', 1042.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'wait', 1049.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Price / T2.Amount), T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.CustomerID = (SELECT CustomerID FROM yearmonth ORDER BY Consumption DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1) GROUP BY T2.CustomerID, T1.Currency;

/*
Gold Result:
(0, 4.028548283406435, 'face')
*/

-- Prediction Query
SELECT T1."CustomerID", SUM(T2."Price") / SUM(T2."Amount") AS "AveragePricePerItem", T1."Currency" FROM "customers" AS T1 INNER JOIN "transactions_1k" AS T2 ON T1."CustomerID" = T2."CustomerID" GROUP BY T1."CustomerID" ORDER BY SUM(T2."Price") DESC, T1."CustomerID" NULLS LAST, AveragePricePerItem NULLS LAST, T1."Currency" NULLS LAST LIMIT 1;

/*
Prediction Result:
(0, 1.007173601147776, 'face')
*/