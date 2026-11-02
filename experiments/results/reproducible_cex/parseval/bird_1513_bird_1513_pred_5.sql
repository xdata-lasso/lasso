-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'g_s_6f1fc3', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 1268590800, 'g_s_6f1fc3', 'puzhsrw');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (0, -1377057208, 'g_s_6f1fc3', 'ilbnp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-1, -1576219117, 'g_s_6f1fc3', '5u');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -1633151678, 'a2y', 'uzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 1236688122, 'dpos', 'ie5');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1274489983, 'gce', '76nium52');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 328305758, 'tliqa1', 'ryytoo3');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, -74849714, '7zw', 'au2dwyrq13');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 1692174491, 'qi2rkf9v', 'x58pz');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, -1612443122, 'd', 'lph2gn');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 580968159, 'cprj', 'u0dz7');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2012-08-25', '9n8c4pgu7v', -1865039888, 1160656988, 1, -992890117, 1914020640, 0.01);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-25', 'b', 1072996612, 13244799, 1, -1659388584, 1526238907, 0.01);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-1, '2012-08-25', 'i', 1236688122, 2087640001, 3, 907682809, 2026480202, 0.01);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (0, '2012-08-25', '!', 1861536320, 44952191, 3, 1151980946, 1620389964, 0.01);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-25', '00t5c4ecigc', 528680845, -1585009206, 1, -53231346, -443340271, 0.01);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-25', '5k5swwqcgs', 247012447, -1980249628, 2, -734455130, 1744686505, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2012-08-25', 'rwbbp6luhvd', -1377057208, -841692980, 3, -1364429300, -1257178728, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2024-06-15', 'nw6klf', 1038707349, 1419861592, 4, 700088193, 374105386, 0.01);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2024-06-15', 'zbuo4nrqrof', 373262291, -472966518, 5, -921187550, -2070843029, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2024-06-15', '9hl7', 1178636309, -1390245819, 6, 1055976837, 1775126557, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, NULL, 'yu78', 244829661, -1362461264, 7, -904834265, -346339240, 0.01);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, NULL, 'f8jegd2', 1675430660, -688509700, 8, -792092619, -1492524358, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (10, NULL, 'q', -664193365, -1070063173, 9, 555413010, 722884590, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' ORDER BY T1.Time DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('dpos',)
*/

-- Prediction Query
SELECT g.Country FROM transactions_1k AS t INNER JOIN gasstations AS g ON t.GasStationID = g.GasStationID WHERE t.Date = '2012-08-25' AND t.Price > 0 ORDER BY t.Time ASC, t.transactionid NULLS LAST, g.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
('dpos',)
*/