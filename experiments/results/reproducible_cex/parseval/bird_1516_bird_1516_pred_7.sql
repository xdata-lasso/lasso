-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'hria2ypuzhs', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '9n8', 't2__b5dccd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'value', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'puzhsrw', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'vd', 't2__b5dccd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'value', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'nw6klf', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'i', 't2__b5dccd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'value', NULL);

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2012-08-26', '12:59:59', 1, 247012447, -1980249628, -734455130, 1744686505, 483.665643);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-26', '12:59:59', 1, 700293388, 906324270, 1908028688, 2122220075, 749.826493);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-26', '12:59:59', 1, 13244799, -1659388584, 1526238907, -1377057208, 304.02808);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2012-08-26', '12:59:59', 3, -55602865, -59984348, -664303813, -1022641847, 97.952323);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2012-08-26', '12:59:59', 4, 1610062532, -106629402, 1871297066, 809183447, 520.784135);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2012-08-26', '13:00:00', 5, -1865039888, 1160656988, -992890117, 1914020640, 795.366812);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2012-08-26', '13:00:00', 6, 1908028688, 2122220075, 1072996612, 13244799, 320.851235);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2012-08-26', '13:00:00', 7, -1377057208, -841692980, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2012-08-26', NULL, 8, 2087640001, 907682809, 2026480202, -1576219117, 75.403642);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (10, '2012-08-26', NULL, 9, 1038707349, 1419861592, 700088193, 374105386, 950.466571);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (11, '2012-08-26', NULL, 10, 1149850321, -1833165707, 1155439218, 1313172851, 322.782838);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-26' AND T1.Time < '13:00:00' AND T2.Currency = 'EUR';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(T1.TransactionID) AS TransactionCount FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-26' AND T1.Time < '13:00:00' AND T2.Currency = 'CZK';

/*
Prediction Result:
(0,)
*/