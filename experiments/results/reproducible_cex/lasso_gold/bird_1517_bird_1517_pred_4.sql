-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1289, 'reveal', 'stand');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1290, 'garden', 'arrive');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1291, 'threat', 'drop');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1292, 'special', 'term');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1293, '1981-08-18', 'almost', 1289, 1297, 1301, 1305, 1309, 1313.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1294, '1981-08-19', 'support', 1290, 1308.0, 1314.0, 1320.0, 1326.0, 1332.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1295, '1981-08-20', 'four', 1291, 1319.0, 1327.0, 1335.0, 1343.0, 1351.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1296, '1981-08-21', 'institution', 1292, 1330.0, 1340.0, 1350.0, 1360.0, 1370.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1318, '1981-08-17', 'almost', 1317, 1297, 1301, 1305, 1309, 1313.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
('reveal',)
*/

-- Prediction Query
SELECT c.segment FROM customers AS c WHERE c.customerid = (SELECT t.customerid FROM transactions_1k AS t ORDER BY t.date ASC, t.transactionid NULLS LAST LIMIT 1);

/*
Prediction Result:
*/