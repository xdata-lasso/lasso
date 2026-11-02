-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'hria2ypu', 'hsrwbbp');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'u', '4nrq');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-24', '5k5swwqcgs', 1, 247012447, -1980249628, -734455130, 1744686505, 124.05);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-24', 'luhvdltti', 1, -1364429300, -1257178728, 1236688122, 2087640001, 124.05);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-24', 'dposiie5unw', 1, -1399556171, 1038707349, 1419861592, 700088193, 124.05);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-24', 'ecigce376n', 2, 1313172851, -761141909, 283598170, 742285925, 124.05);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-24', 'rofqyp5s5b', 2, 2107872094, 882961052, 743312762, -1822992503, 124.05);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2012-08-24', 'liqa1', 2, 2074205376, 274769912, -188151580, 226938182, 124.05);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2024-06-15', '72k', 1, -1390245819, 1055976837, 1775126557, -74849714, 124.05);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2012-08-24', '7zw', 1, 481163439, 2123196517, 364869063, -953437896, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2012-08-24', '3pyu78d', 1, -977635379, 1661181156, -1372125820, -2031361952, 124.05);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2012-08-24', 'p5qi2rk', 1, -705985602, 537874887, -461695645, 836513442, 124.05);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2012-08-24', '8jegd21vy9ux', 1, -1492524358, -1612443122, -2050247126, -736979194, 124.05);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201201', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '201201', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__0b9e5f', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID, T2.Date, T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Price = 124.05 AND T2.Date = '201201';

/*
Gold Result:
(1, '201201', 1.0)
(1, '201201', 1.0)
(1, '201201', 1.0)
(1, '201201', 1.0)
(1, '201201', 1.0)
(1, '201201', 1.0)
*/

-- Prediction Query
SELECT T1.Price, T2.Date, T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Price = 124.05 AND T2.Date LIKE '201201%';

/*
Prediction Result:
(124.05, '201201', 1.0)
(124.05, '201201', 1.0)
(124.05, '201201', 1.0)
(124.05, '201201', 1.0)
(124.05, '201201', 1.0)
(124.05, '201201', 1.0)
*/