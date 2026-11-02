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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '8c4p', 't2__8cc3b4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'value', NULL);

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, '8c4p', 'EUR');

-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1, '9n8', '4');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, 1, 'lbn', 'rmdp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 1, '52zbuo4nrq', 'rofqyp5s5b');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1871297066, 'u7vfe4hria2y', 'uzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, NULL, 'value', 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483642, 2, 'u7', 'fe4hri');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483641, 3, 'a2ypuzhsrwbb', 'p6luhvdlttil');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483640, 2, 'n', 'rmdp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483639, 3, 'siie', 'unw6klfa');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-10-19', 'u7', 1, -734455130, 2, 1744686505, -1633151678, 134.487977);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2020-01-20', 'ypuzhsrw', 1, 1908028688, 3, 2122220075, 1072996612, 503.083789);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2022-07-21', 'siie5unw6k', 2, 1151980946, 1, 1620389964, 546571701, 801.414196);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2024-09-18', '5c4ec', 3, -1683203397, 1, 528680845, -1585009206, 191.847248);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2020-04-03', '02eu', 1, -868774469, 2, -1068298341, -314162272, 997.73177);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2024-03-26', 'oo3o9', 1, -1666765085, 2, 1178636309, -1390245819, 763.856372);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2024-03-14', '4ji7zwa', 2, 2123196517, 1, 364869063, -953437896, 433.533777);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2025-02-23', 'yu78', 3, 244829661, 1, -1362461264, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2025-04-09', 'p5qi2rk', 1, -705985602, 2, 537874887, -461695645, 694.765963);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2021-08-12', 'gd', 1, -283454505, 2, 233994589, 1442655647, 479.592965);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2023-12-18', 'd', 2, -736979194, 1, 2103044118, -1642259219, 109.083092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2022-04-21', 'q', 3, -664193365, 1, -1070063173, 555413010, 668.309685);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2021-04-09', 'cprj', 1, -841004020, 2, -361507387, 401805964, 154.065416);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2022-12-06', 'n2f3dqv0g', 1, 1382410067, 2, 1631231566, 172461907, 874.028321);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2021-10-23', 'zbilyrkn', 1, -688098735, 2, 1784916884, 37673509, 591.134092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2021-03-28', 'f8jswwl', 1, 1255343543, 3, -541746689, 1294666887, 379.883722);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2020-09-03', 'z16ni', 1, 2011234363, 2, -1483100200, -7597509, 651.586084);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483631, '2021-05-12', 'ogrgjd8y', 1, 1129658414, 3, 1250290042, -1717646459, 105.078878);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-06-17', '5sw', 2, 1258409369, 4, -1981402255, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2023-01-03', 'wbbp6luhvdlt', 3, -841692980, 5, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2025-06-17', '5sw', 5, 1258409369, 6, -1981402255, -890215420, 572.766956);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.ChainID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.Currency = 'EUR';

/*
Gold Result:
(1,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT T3.ChainID FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN gasstations AS T3 ON T2.GasStationID = T3.GasStationID WHERE T1.Currency = 'Euro';

/*
Prediction Result:
*/