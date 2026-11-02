-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, 11, '5k5swwqcgs', '9n8');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 11, 'rwbbp', 'luhvdltti');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1, 'u7', 'fe4hri');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, NULL, 'value', 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 11, '9n8c4pgu7v', 'e4');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2020-06-08', 't1__a4fa89', -106629402, 1871297066, 1, 809183447, 89267185, 86.520366);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2020-09-26', 't1__a4fa89', -1633151678, -252690330, 1, 1115440883, 1644814318, 841.297061);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-06-17', '5sw', 1258409369, -1981402255, 2, -890215420, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2020-01-20', 'ypuzhsrw', 1908028688, 2122220075, 4, 1072996612, 13244799, 320.851235);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2025-06-17', NULL, -1437333179, -921145356, 5, 1258409369, -1981402255, 292.730571);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2021-05-05', 'C', -992890117, 1914020640, 1268590800, 1219478689, -1670923962, 663.049759);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2023-11-30', 'A', 1908028688, 2122220075, 1072996612, 13244799, -1659388584, 855.355181);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2022-01-04', '_', -845863578, -1610064545, 429706943, 462974032, -1137908826, 619.836822);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2023-03-17', 'A', -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, 587.783596);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2024-07-24', '_', 546571701, 947159877, 1990080517, 1408123494, -1964997180, 734.586266);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2021-03-18', 'A', -1833165707, 1155439218, 1313172851, -761141909, 283598170, 452.706544);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2024-06-13', 'G', -747753377, 902887186, -967741825, 775304493, 373262291, 389.878901);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2025-06-25', 'A', 1884179925, 902551284, 2107872094, 882961052, 743312762, 825.231787);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.Time FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.ChainID = 11;

/*
Gold Result:
('t1__a4fa89',)
(None,)
*/

-- Prediction Query
SELECT T2.Time FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ChainID = 11;

/*
Prediction Result:
('t1__a4fa89',)
('t1__a4fa89',)
(None,)
*/