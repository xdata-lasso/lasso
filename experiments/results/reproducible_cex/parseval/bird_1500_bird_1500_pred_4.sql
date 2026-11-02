-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '8c4p', 'u7');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'c4ecigce', '76nium52');

-- Inserting into table: products --
INSERT INTO "products" ("productid", "description") VALUES (1, 't1__9dc3c5');

INSERT INTO "products" ("productid", "description") VALUES (2, 't1__9dc3c5');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2025-06-17', '5sw', 1, 1258409369, -1981402255, 1, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2020-09-26', 'hria2ypu', 1, 1644814318, 1465859724, 2, -1349201381, 737.440743);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2023-10-03', 'l', 1, -845863578, -1610064545, 2, 429706943, 240.969194);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2023-01-01', 'dpos', 1, -1576219117, -1823627488, 3, -1209887326, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2021-10-25', 'fa9', 3, 1620389964, 546571701, 1, 947159877, 963.351729);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2024-06-13', 'u', 1, -1179823637, 1119186446, 3, 781505063, 597.420508);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2022-06-23', 'fqyp5s5bbp0', 3, 743312762, -1822992503, 1, -868774469, 138.017996);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2022-10-26', '1', 1, 2074205376, 274769912, 3, -188151580, 552.838162);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2022-02-06', '72klex14ji7z', 3, -2081315180, 1909986641, 1, 1485335077, 721.918386);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2024-04-09', 'q13py', 1, 244829661, -1362461264, 1, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2025-04-09', 'p5qi2rk', 1, -705985602, 537874887, 1, -461695645, 694.765963);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2021-08-12', 'gd', 1, -283454505, 233994589, 1, 1442655647, 479.592965);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201309A', 328.996339);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '201309A', 816.814398);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'AAAAAAA', 353.366837);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't3__353d37', 50.647649);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Description FROM products AS T1 JOIN transactions_1k AS T2 ON T1.ProductID = T2.ProductID JOIN yearmonth AS T3 ON T2.CustomerID = T3.CustomerID WHERE SUBSTRING(T3.Date, 1, 6) = '201309';

/*
Prediction Result:
('t1__9dc3c5',)
('t1__9dc3c5',)
('t1__9dc3c5',)
('t1__9dc3c5',)
('t1__9dc3c5',)
('t1__9dc3c5',)
*/