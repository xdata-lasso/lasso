-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'CZE', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -1349201381, 'CZE', 'hvdlttilbnpr');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 1219478689, 'CZE', 'uzhsrwbbp6lu');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1019800248, 'CZE', 'dlttil');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, -1179823637, 'CZE', 'rqro');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 775304493, 'CZE', 'qyp5s5bbp0');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -1666765085, 't2__44d5fc', '72klex14ji7z');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-27', '8c4pgu7vfe', -1633151678, -252690330, 1, 1115440883, 1644814318, 841.297061);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2022-02-26', 'dposiie5unw', -1399556171, 1038707349, 2, 1419861592, 700088193, 587.103196);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2020-06-23', 'gce', -1585009206, -53231346, 2, -443340271, 757448742, 225.300904);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2022-04-13', 'rqrofqyp5s', 902551284, 2107872094, 2, 882961052, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2020-11-05', 'tliqa1', 2074205376, 274769912, 2, -188151580, 226938182, 187.343342);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-11-03', 'klex14ji', -453362185, 481163439, 1, 2123196517, 364869063, 278.010437);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2024-11-10', '3pyu78d99r', -1362461264, -904834265, 1, -346339240, 1692174491, 495.297639);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2022-12-05', '2rk', -705985602, 537874887, 1, -461695645, 836513442, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2021-08-12', 'gd', -283454505, 233994589, 1, 1442655647, -87647544, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2023-12-18', 'd', -736979194, 2103044118, 1, -1642259219, 1298861365, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2020-08-28', 'wnqcx', 722884590, 580968159, 1, -1245312912, 1575412235, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2023-01-09', 'tu0', -1898531797, -1748371085, 1, -1742081330, 894242932, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2025-01-20', '3d', 513454646, -688216274, 1, 331812443, 1382410067, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-06-17', '5sw', 1258409369, -1981402255, 7, -890215420, 1610062532, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2025-04-30', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2020-04-02', 'nprmdposii', -1823627488, -1209887326, 11, -1399556171, 1038707349, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (10, '2024-07-24', '00t5c4ecigc', 528680845, -1585009206, -53231346, -443340271, 757448742, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2024-12-15', 'eutliqa11r', 2137741668, -525979501, 2, 1898504886, 624571013, 882.985782);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Gold Result:
(323.3210274,)
*/

-- Prediction Query
SELECT AVG(transactions_1k.Price * transactions_1k.Amount) AS AverageTotalPrice FROM transactions_1k INNER JOIN gasstations ON transactions_1k.GasStationID = gasstations.GasStationID WHERE gasstations.Country = 'CZE';

/*
Prediction Result:
(465198731865.1714,)
*/