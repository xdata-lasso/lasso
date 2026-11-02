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

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 1465859724, 'CZE', 'rwbbp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -1209887326, 'CZE', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -55602865, 't2__46400a', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, -55602865, 'CZE', 'swwqcgsk');

-- Inserting into table: products --
INSERT INTO "products" ("productid", "description") VALUES (1, 't3__953995');

INSERT INTO "products" ("productid", "description") VALUES (2, 't3__953995');

INSERT INTO "products" ("productid", "description") VALUES (-2147483647, 't3__953995');

INSERT INTO "products" ("productid", "description") VALUES (3, 't3__953995');

INSERT INTO "products" ("productid", "description") VALUES (4, 'sr');

INSERT INTO "products" ("productid", "description") VALUES (5, 'tti');

INSERT INTO "products" ("productid", "description") VALUES (6, NULL);

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-27', '8c4pgu7vfe', -1633151678, -252690330, 1, 1, 1115440883, 882.963176);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2025-08-22', 'uhv', 1526238907, -1377057208, 1, 2, -841692980, 182.319045);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2022-04-29', 'rmdp', 2026480202, -1576219117, 1, 1, -1823627488, 327.753528);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2025-07-01', '4', 374105386, 1274489983, 2, 1, -1683203397, 623.093099);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2025-03-28', '6nium52zb', 757448742, -1179823637, 1, 2, 1119186446, 590.639932);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2023-02-21', 'qrofqyp5s5b', 2107872094, 882961052, 2, 1, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2020-11-05', 'tliqa1', 2074205376, 274769912, 1, 2, -188151580, 552.838162);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2022-02-06', '72klex14ji7z', -2081315180, 1909986641, 2, 1, 1485335077, 721.918386);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-04-09', 'q13py', 244829661, -1362461264, 1, 2, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-04-09', 'p5qi2rk', -705985602, 537874887, 1, 1, -461695645, 694.765963);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2021-08-12', 'gd', -283454505, 233994589, 1, 1, 1442655647, 479.592965);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2023-12-18', 'd', -736979194, 2103044118, 1, 1, -1642259219, 109.083092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2022-04-27', '8c4pgu7vfe', -1633151678, -252690330, 2, 4, 1115440883, 882.963176);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2023-11-30', 'b', 1072996612, 13244799, 4, 5, -1659388584, 855.355181);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2022-04-27', '8c4pgu7vfe', -1633151678, -252690330, 5, 6, 1115440883, 882.963176);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Country = 'CZE';

/*
Gold Result:
('t3__953995',)
('t3__953995',)
('t3__953995',)
('t3__953995',)
('t3__953995',)
('t3__953995',)
('t3__953995',)
('t3__953995',)
('t3__953995',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT T3.Description FROM "transactions_1k" AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Country = 'CZE';

/*
Prediction Result:
('t3__953995',)
(None,)
*/