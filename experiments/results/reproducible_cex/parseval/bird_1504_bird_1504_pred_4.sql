-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-01-01', '5k5swwqcgs', 247012447, -1980249628, -734455130, 1744686505, -1633151678, 134.487977);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-01-01', '2', 1219478689, -1670923962, 700293388, 906324270, NULL, 944.247544);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-01-01', 'p', 13244799, -1659388584, 1526238907, -1377057208, NULL, 304.02808);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-01-01', 'bnp', 1236688122, 2087640001, 907682809, 2026480202, NULL, 133.007885);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-01-01', '5u', 1861536320, 44952191, 1151980946, 1620389964, NULL, 627.258639);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-01-01', '0t5c4ecigc', 528680845, -1585009206, -53231346, -443340271, 1, 676.357279);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-01-01', '4nrq', 418417917, -1031969798, -1106983592, 1884179925, 1, 499.570479);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, NULL, '5k5swwqcgs', 247012447, -1980249628, -734455130, 1744686505, -1633151678, 134.487977);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2012-01-01', '2', 1219478689, -1670923962, 700293388, 906324270, 1908028688, 994.117864);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2012-01-01', 'p6luhvdlttil', 429706943, 462974032, -1137908826, -918961358, -1602639011, 489.397796);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2012-01-01', 'w6kl', 1620389964, 546571701, 947159877, 1990080517, 1408123494, 983.124993);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2012-01-01', '4', 374105386, 1274489983, -1683203397, 528680845, -1585009206, 191.847248);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2012-01-01', '52zbuo4nrq', 418417917, -1031969798, -1106983592, 1884179925, 902551284, 22.720462);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (10, '2012-01-01', '02eu', -868774469, -1068298341, -314162272, 2137741668, -525979501, 668.928822);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (11, '2012-01-01', 'o3o9', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 482.572691);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(Amount) FROM transactions_1k WHERE Date LIKE '2012-01%';

/*
Gold Result:
(64705062.9,)
*/

-- Prediction Query
SELECT AVG(amount * price) AS averagetotalprice FROM transactions_1k WHERE STRFTIME('%Y-%m', "transactions_1k"."Date") = '2012-01';

/*
Prediction Result:
(249841101945.00848,)
*/