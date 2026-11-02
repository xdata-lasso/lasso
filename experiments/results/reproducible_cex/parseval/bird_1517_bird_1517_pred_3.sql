-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 't2__6585b7', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 't2__6585b7', 'puzhsrw');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 't2__6585b7', 'b');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'u7', 'fe4hri');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'vd', 'tti');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'w6kl', 'a9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '4nrq', 'rofqyp5s5b');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (11, 'too3o9h', '72k');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, NULL, 'value');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'yrq13pyu78d9', 'rljsl0b4y');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (14, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2021-12-04', '9n8c4pgu7v', 1, -1865039888, 1160656988, -992890117, 1914020640, 795.366812);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2022-08-24', 'luhvdltti', 3, -1364429300, -1257178728, 1236688122, 2087640001, 666.330692);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (0, '1969-12-31', 'p', 3, 2026480202, -1576219117, -1823627488, -1209887326, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-1, '1970-01-01', 'lfa', 3, 1419861592, 700088193, 374105386, 1274489983, 128.76421);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2021-03-18', 'e', 1, -1585009206, -53231346, -443340271, 757448742, 225.300904);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-06-17', '5sw', 3, 1258409369, -1981402255, -890215420, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2020-01-20', 'ypuzhsrw', 5, 1908028688, 2122220075, 1072996612, 13244799, 320.851235);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2022-01-16', 'n', 7, 462974032, -1137908826, -918961358, -1602639011, 489.397796);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2024-07-24', '00t5c4ecigc', 9, 528680845, -1585009206, -53231346, -443340271, 676.357279);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2020-04-03', '02eu', 11, -868774469, -1068298341, -314162272, 2137741668, 881.232072);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2021-12-23', 'x1', 13, -74849714, 105869088, -2081315180, 1909986641, 845.831524);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
('u7',)
*/

-- Prediction Query
SELECT T1.Segment FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY T2.Date, T1.customerid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/