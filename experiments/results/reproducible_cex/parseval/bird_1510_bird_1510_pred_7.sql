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

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -1349201381, 'CZE', 'hvdlttilbnpr');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, -55602865, 'CZE', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 1610062532, 'CZE', 'pgu7vfe4');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, -45536098, 'CZE', 'w6kl');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 1620389964, 'CZE', '00t5c4ecigc');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -1068298341, 't2__9eaa85', '1ryytoo');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-27', '8c4pgu7vfe', -1633151678, -252690330, 1, 1115440883, 1644814318, 841.297061);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2022-02-26', 'dposiie5unw', -1399556171, 1038707349, 3, 1419861592, 700088193, 587.103196);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2020-06-23', 'gce', -1585009206, -53231346, 3, -443340271, 757448742, 225.300904);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2022-04-13', 'rqrofqyp5s', 902551284, 2107872094, 3, 882961052, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2020-11-05', 'tliqa1', 2074205376, 274769912, 3, -188151580, 226938182, 187.343342);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-11-03', 'klex14ji', -453362185, 481163439, 1, 2123196517, 364869063, 278.010437);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2024-11-10', '3pyu78d99r', -1362461264, -904834265, 1, -346339240, 1692174491, 495.297639);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2022-12-05', '2rk', -705985602, 537874887, 1, -461695645, 836513442, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2021-08-12', 'gd', -283454505, 233994589, 1, 1442655647, -87647544, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2023-12-18', 'd', -736979194, 2103044118, 1, -1642259219, 1298861365, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2020-08-28', 'wnqcx', 722884590, 580968159, 1, -1245312912, 1575412235, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2023-01-09', 'tu0', -1898531797, -1748371085, 1, -1742081330, 894242932, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2025-01-20', '3d', 513454646, -688216274, 1, 331812443, 1382410067, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2021-05-05', 'ia2yp', -1670923962, 700293388, 6, 906324270, 1908028688, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2020-03-30', 'p6luhvdlttil', 429706943, 462974032, -1137908826, -918961358, -1602639011, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2020-10-26', '76nium52', -443340271, 757448742, 10, -1179823637, 1119186446, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (11, '2023-02-21', 'qrofqyp5s5b', 2107872094, 882961052, 743312762, -1822992503, -868774469, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-02-11', '9hl7', 1178636309, -1390245819, 3, 1055976837, 1775126557, 482.572691);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Gold Result:
(323.3210274,)
*/

-- Prediction Query
SELECT AVG(t1.Amount * t1.Price) AS average_total_price FROM transactions_1k AS t1 JOIN gasstations AS t2 ON t1.GasStationID = t2.GasStationID WHERE t2.Country = 'CZE';

/*
Prediction Result:
(465274420915.77136,)
*/