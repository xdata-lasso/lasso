-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 't2__1c7841', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1465859724, 't2__1c7841', 'rwbbp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 13244799, 't2__1c7841', 'hvdltt');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 2026480202, 't2__1c7841', 'ie5');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1610062532, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 1610062532, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, -1585009206, '52zb', 'uo4nrqrofqy');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 1, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2022-04-27', '8c4pgu7vfe', -1633151678, -252690330, 1, 2, 1115440883, 882.963176);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2021-05-27', 'bnp', 1236688122, 2087640001, 3, 2, 907682809, 227.766936);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2023-09-04', 'w6kl', 1620389964, 546571701, 2, 2, 947159877, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2023-05-08', 'c4ecigce', -1585009206, -53231346, 2, 2, -443340271, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2023-08-27', '4nrq', 418417917, -1031969798, 2, 2, -1106983592, -1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2023-03-15', 'bbp02eut', -1347802441, 1673584235, 2, 2, -2118135981, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2024-10-14', 'yytoo', 1644911394, -1666765085, 1, 2, 1178636309, 176.308171);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2024-03-14', '4ji7zwa', 2123196517, 364869063, 1, 2, -953437896, 433.533777);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2025-02-23', 'yu78', 244829661, -1362461264, 1, 2, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2025-04-09', 'p5qi2rk', -705985602, 537874887, 1, 2, -461695645, 694.765963);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-06-17', '5sw', 1258409369, -1981402255, 4, 1, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2023-01-03', 'wbbp6luhvdlt', -841692980, -1364429300, 5, NULL, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-06-17', '5sw', 1258409369, -1981402255, 6, 2, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2023-01-03', 'wbbp6luhvdlt', -841692980, -1364429300, 8, 2, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2025-07-01', '4', 374105386, 1274489983, 10, 2, -1683203397, 623.093099);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__1c7841',)
*/

-- Prediction Query
SELECT T3.Country FROM transactions_1k AS T1 JOIN products AS T2 ON T1.ProductID = T2.ProductID JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST, T3.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/