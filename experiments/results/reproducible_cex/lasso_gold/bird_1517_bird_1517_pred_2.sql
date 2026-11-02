-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1233, 'none', 'science');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1234, 'determine', 'write');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1235, 'religious', 'result');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1236, 'example', 'raise');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1261, 'hear', 'maintain');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1262, 'shoulder', 'hundred');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1263, 'election', 'expect');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1264, 'common', 'wish');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1237, '1973-11-10', 'push', 1233, 1269, 1273, 1277, 1281, 1285.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1238, '2099-12-31', 'politics', 1234, 1252.0, 1258.0, 1264.0, 1270.0, 1276.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1239, '2099-12-31', 'prove', 1235, 1263.0, 1271.0, 1279.0, 1287.0, 1295.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1240, '2099-12-31', 'Congress', 1236, 1274.0, 1284.0, 1294.0, 1304.0, 1314.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1265, '1973-11-10', 'away', 1261, 1241, 1245, 1249, 1253, 1257.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1266, '2099-12-31', 'rise', 1262, 1280.0, 1286.0, 1292.0, 1298.0, 1304.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1267, '2099-12-31', 'onto', 1263, 1291.0, 1299.0, 1307.0, 1315.0, 1323.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1268, '2099-12-31', 'discuss', 1264, 1302.0, 1312.0, 1322.0, 1332.0, 1342.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
('none',)
*/

-- Prediction Query
SELECT "customers"."segment" FROM "customers" INNER JOIN "transactions_1k" ON "customers"."customerid" = "transactions_1k"."customerid" ORDER BY "transactions_1k"."date", "transactions_1k"."time", customers.customerid NULLS LAST, transactions_1k.transactionid NULLS LAST LIMIT 1;

/*
Prediction Result:
('hear',)
*/