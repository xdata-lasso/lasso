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

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1219478689, 'CZE', 'uzhsrwbbp6lu');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -1633151678, 'CZE', 'a2y');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 13244799, 'CZE', 'hvdltt');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1861536320, 't2__059205', '6klfa9');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, -53231346, 't2__059205', 'zbuo4nrqrof');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, -314162272, 't2__059205', 'ytoo3o9');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 1, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2012-01-01', '9n8c4pgu7v', -1865039888, 1160656988, 1, -992890117, 1914020640, 795.366812);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-01-01', 'hvdlttilbnpr', 2087640001, 907682809, 1, 2026480202, -1576219117, 75.403642);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-01-01', 'nw6klf', 1038707349, 1419861592, 1, 700088193, 374105386, 950.466571);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2011-12-31', '5k5swwqcgs', 247012447, -1980249628, 3, -734455130, 1744686505, 483.665643);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, NULL, 'uzhs', 700293388, 906324270, 4, 1908028688, 2122220075, 749.826493);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2012-01-01', 'lbn', 462974032, -1137908826, 5, -918961358, -1602639011, 489.397796);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2011-12-31', '00t5c4e', 1274489983, -1683203397, 6, 528680845, -1585009206, 191.847248);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, NULL, 'qyp5s5bbp0', 743312762, -1822992503, 7, -868774469, -1068298341, 427.383654);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2012-01-01', 'l7', 1178636309, -1390245819, 8, 1055976837, 1775126557, 482.572691);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (10, '2011-12-31', '7zw', 481163439, 2123196517, 9, 364869063, -953437896, 433.533777);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (11, NULL, 'pyu78d99', -977635379, 1661181156, 10, -1372125820, -2031361952, 884.000446);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND STRFTIME('%Y', T1.Date) >= '2012';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM transactions_1k AS T1 JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND T1.Date > '2012-01-01';

/*
Prediction Result:
(0,)
*/