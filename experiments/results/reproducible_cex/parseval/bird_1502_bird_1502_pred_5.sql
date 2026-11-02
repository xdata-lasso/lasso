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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'hvdltt', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '8c4p', 't2__709b35');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'value', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, '8c4p', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'dpos', 'EUR');

-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1, '9n8', '4');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, 1427161052, 'z16ni', 'jai');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 1871297066, 'u7vfe4hria2y', 'uzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1871297066, 'u7vfe4hria2y', 'uzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, NULL, 'value', 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, -1576219117, '5u', 'w6kl');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, NULL, 'value', 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-10-19', 'u7', 1, -734455130, 2, 1744686505, -1633151678, 134.487977);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2020-01-20', 'ypuzhsrw', 1, 1908028688, 1, 2122220075, 1072996612, 503.083789);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2021-05-27', 'bnp', 2, 1236688122, 2, 2087640001, 907682809, 227.766936);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2023-03-17', 'ie5', 3, -1209887326, 1, -1399556171, 1038707349, 587.783596);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2024-07-24', '00t5c4ecigc', 1, 528680845, 2, -1585009206, -53231346, 816.814398);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2024-06-13', 'u', 1, -1179823637, 2, 1119186446, 781505063, 597.420508);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2022-06-23', 'fqyp5s5bbp0', 2, 743312762, 2, -1822992503, -868774469, 138.017996);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2022-10-26', '1', 3, 2074205376, 1, 274769912, -188151580, 552.838162);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2022-02-06', '72klex14ji7z', 1, -2081315180, 2, 1909986641, 1485335077, 721.918386);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2024-04-09', 'q13py', 1, 244829661, 2, -1362461264, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2025-04-09', 'p5qi2rk', 2, -705985602, 2, 537874887, -461695645, 694.765963);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2021-08-12', 'gd', 3, -283454505, 1, 233994589, 1442655647, 479.592965);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2023-12-18', 'd', 1, -736979194, 2, 2103044118, -1642259219, 109.083092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2022-04-21', 'q', 1, -664193365, 2, -1070063173, 555413010, 668.309685);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2021-04-09', 'cprj', 1, -841004020, 2, -361507387, 401805964, 154.065416);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2022-12-06', 'n2f3dqv0g', 1, 1382410067, 1, 1631231566, 172461907, 874.028321);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2021-10-23', 'zbilyrkn', 1, -688098735, 2, 1784916884, 37673509, 591.134092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483631, '2021-03-28', 'f8jswwl', 1, 1255343543, 1, -541746689, 1294666887, 379.883722);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-06-17', '5sw', 2, 1258409369, 3, -1981402255, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2023-01-03', 'wbbp6luhvdlt', 3, -841692980, 4, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2025-06-17', '5sw', 5, 1258409369, 5, -1981402255, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2023-01-03', 'wbbp6luhvdlt', 6, -841692980, 7, -1364429300, -1257178728, 787.938887);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.ChainID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.Currency = 'EUR';

/*
Gold Result:
(1,)
(1427161052,)
(1871297066,)
(-1576219117,)
*/

-- Prediction Query
SELECT T2.ChainID FROM customers AS T1 INNER JOIN transactions_1k AS T3 ON T1.CustomerID = T3.CustomerID INNER JOIN gasstations AS T2 ON T3.GasStationID = T2.GasStationID WHERE T1.Currency = 'EUR';

/*
Prediction Result:
(1,)
(1427161052,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1427161052,)
(1,)
(1427161052,)
(1871297066,)
(-1576219117,)
*/