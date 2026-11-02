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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'lfa', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'rwbbp', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'luhvdltti', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'p', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, '02eutliqa11r', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'kf9vq', 't3__cbeebb');

-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, 247012447, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 13244799, 'hvdltt', 'lbn');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, -1364429300, 'nprmdposii', '5u');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1861536320, '6klfa9', '00t5c4e');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 2137741668, 'ytoo3o9hl7', 'klex14ji');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, -453362185, 'au2dwyrq13', 'yu78');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 537874887, 'z0f8jegd21vy', '9uxj4hwbdvl');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2024-06-23', 'sr', 1, 906324270, 1, 1908028688, 2122220075, 749.826493);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2022-09-14', 'mdpos', 1, -1576219117, 3, -1823627488, -1209887326, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2024-07-24', '00t5c4ecigc', 3, 528680845, 1, -1585009206, -53231346, 816.814398);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2024-06-13', 'u', 1, -1179823637, 3, 1119186446, 781505063, 597.420508);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2022-06-23', 'fqyp5s5bbp0', 3, 743312762, 1, -1822992503, -868774469, 138.017996);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2022-10-26', '1', 1, 2074205376, 3, 274769912, -188151580, 552.838162);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2022-02-06', '72klex14ji7z', 3, -2081315180, 1, 1909986641, 1485335077, 721.918386);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2024-04-09', 'q13py', 1, 244829661, 3, -1362461264, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2025-04-09', 'p5qi2rk', 3, -705985602, 1, 537874887, -461695645, 694.765963);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2021-08-12', 'gd', 1, -283454505, 1, 233994589, 1442655647, 479.592965);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2023-12-18', 'd', 1, -736979194, 1, 2103044118, -1642259219, 109.083092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2022-04-21', 'q', 1, -664193365, 1, -1070063173, 555413010, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2025-07-02', 'hncprjtu0dz', 1, -1748371085, 1, -1742081330, 894242932, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2025-01-20', '3d', 1, 513454646, 1, -688216274, 331812443, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483634, '2020-06-01', '9', 1, 172461907, 1, 1606439408, 1443629118, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483633, '2025-03-14', 'bilyrkn', 1, -688098735, 1, 1784916884, 37673509, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2021-03-28', 'f8jswwl', 1, 1255343543, 1, -541746689, 1294666887, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2025-06-17', '5sw', 1, 1258409369, 8, -1981402255, -890215420, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2022-04-27', '8c4pgu7vfe', -1633151678, -252690330, 1115440883, 1644814318, 1465859724, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (12, '2020-06-23', 'gce', 1, -1585009206, 14, -53231346, -443340271, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '2023-08-27', '4nrq', 418417917, -1031969798, -1106983592, 1884179925, 902551284, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2020-07-21', '9rljsl0b4', 3, 1649269347, 3, -1116181514, 1255852738, 137.842122);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Currency = 'EUR';

/*
Gold Result:
(433.65070344444445,)
*/

-- Prediction Query
SELECT AVG(T1.Amount * T1.Price) AS AverageTotalPrice FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR';

/*
Prediction Result:
(98336600890.36601,)
*/