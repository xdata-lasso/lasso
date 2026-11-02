-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 't2__268650', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 1219478689, 't2__268650', 'uzhsrwbbp6lu');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-1, 743312762, 't2__268650', 'eutliqa11r');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (0, 2137741668, 't2__268650', 'ytoo3o9hl7');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -1633151678, 'a2y', 'uzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, -1633151678, 'a2y', 'uzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 1119186446, 'rqrofqyp5s', 'bbp02eut');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 624571013, 'o9hl72kl', 'x1');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 1, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2012-08-25', '9n8c4pgu7v', -1865039888, 1160656988, 1, -992890117, 1914020640, 795.366812);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-25', 'hvdlttilbnpr', 2087640001, 907682809, 1, 2026480202, -1576219117, 75.403642);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-1, '2012-08-25', '@', -1209887326, -1399556171, 4, 1038707349, 1419861592, 663.001988);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (0, '2012-08-25', '0', 374105386, 1274489983, 1, -1683203397, 528680845, 467.07027);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-25', 'nium52zbu', -1179823637, 1119186446, 1, 781505063, 418417917, 220.906948);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-25', 'qy', -1106983592, 1884179925, 1, 902551284, 2107872094, 705.580387);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2024-06-15', '5k5swwqcgs', 247012447, -1980249628, 2, -734455130, 1744686505, 483.665643);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, NULL, 'rwbbp6luhvd', -1377057208, -841692980, 3, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2012-08-25', '5k5swwqcgs', 247012447, -1980249628, 4, -734455130, 1744686505, 483.665643);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2012-08-25', 'rwbbp6luhvd', -1377057208, -841692980, 6, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2012-08-25', 'c4ecigce', -1585009206, -53231346, 8, -443340271, 757448742, 225.300904);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2012-08-25', 'iqa', -314162272, 2137741668, 10, -525979501, 1898504886, 937.856955);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' ORDER BY T1.Time DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('dposiie5unw',)
*/

-- Prediction Query
SELECT g.Country FROM gasstations AS g JOIN (SELECT GasStationID FROM transactions_1k WHERE Date = '2012-08-25' ORDER BY Time ASC, transactions_1k.transactionid NULLS LAST LIMIT 1) AS t ON g.GasStationID = t.GasStationID;

/*
Prediction Result:
('t2__268650',)
*/