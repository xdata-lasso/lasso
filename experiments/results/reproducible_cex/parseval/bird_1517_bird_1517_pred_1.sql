-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 't2__3ab42a', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 't2__3ab42a', 'puzhsrw');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'u7', 'fe4hri');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'vd', 'tti');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'w6kl', 'a9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, '4nrq', 'rofqyp5s5b');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'too3o9h', '72k');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (11, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, 'yrq13pyu78d9', 'rljsl0b4y');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2021-12-04', '9n8c4pgu7v', 1, -1865039888, 1160656988, -992890117, 1914020640, 795.366812);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2020-05-06', 'p', 1, 13244799, -1659388584, 1526238907, -1377057208, 304.02808);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-1, '1969-12-31', 'bnp', 4, 1236688122, 2087640001, 907682809, 2026480202, 133.007885);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (0, '1970-01-01', '5u', 1, 1861536320, 44952191, 1151980946, 1620389964, 627.258639);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2024-09-18', '5c4ec', 1, -1683203397, 528680845, -1585009206, -53231346, 816.814398);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2024-06-13', 'u', 1, -1179823637, 1119186446, 781505063, 418417917, 220.906948);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-06-17', '5sw', 2, 1258409369, -1981402255, -890215420, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2020-01-20', 'ypuzhsrw', 4, 1908028688, 2122220075, 1072996612, 13244799, 320.851235);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2022-01-16', 'n', 6, 462974032, -1137908826, -918961358, -1602639011, 489.397796);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2024-07-24', '00t5c4ecigc', 8, 528680845, -1585009206, -53231346, -443340271, 676.357279);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2020-04-03', '02eu', 10, -868774469, -1068298341, -314162272, 2137741668, 881.232072);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2021-12-23', 'x1', 12, -74849714, 105869088, -2081315180, 1909986641, 845.831524);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
('vd',)
*/

-- Prediction Query
SELECT Segment FROM customers WHERE CustomerID = (SELECT MIN(CustomerID) FROM customers);

/*
Prediction Result:
('t2__3ab42a',)
*/