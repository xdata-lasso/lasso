-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 't2__440f6d', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1268590800, 't2__440f6d', 'puzhsrw');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 1908028688, 't2__440f6d', 'p');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -1633151678, 'a2y', 'uzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1236688122, 'dpos', 'ie5');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1274489983, 'gce', '76nium52');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 328305758, 'tliqa1', 'ryytoo3');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, -74849714, '7zw', 'au2dwyrq13');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 1692174491, 'qi2rkf9v', 'x58pz');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-24', '9n8c4pgu7v', -1865039888, 1160656988, 1, -992890117, 1914020640, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-24', 'luhvdltti', -1364429300, -1257178728, 2, 1236688122, 2087640001, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-24', 'dposiie5unw', -1399556171, 1038707349, 1, 1419861592, 700088193, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-24', 'ecigce376n', 1313172851, -761141909, 3, 283598170, 742285925, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-24', 'u', -1179823637, 1119186446, 3, 781505063, 418417917, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2012-08-24', 'fqyp', -921187550, -2070843029, 3, 328305758, -751275471, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-24', 'iqa', -314162272, 2137741668, 1, -525979501, 1898504886, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-24', 'o3o9hl72klex', 1775126557, -74849714, 1, 105869088, -2081315180, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-06-15', '2dwyrq13pyu7', 244829661, -1362461264, 1, -904834265, -346339240, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2012-08-24', 'yp5qi2rk', -705985602, 537874887, 1, -461695645, 836513442, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2012-08-24', '5k5swwqcgs', 247012447, -1980249628, 3, -734455130, 1744686505, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2024-06-15', 'rwbbp6luhvd', -1377057208, -841692980, 4, -1364429300, -1257178728, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2024-06-15', 'nw6klf', 1038707349, 1419861592, 5, 700088193, 374105386, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, NULL, 'zbuo4nrqrof', 373262291, -472966518, 6, -921187550, -2070843029, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, NULL, '9hl7', 1178636309, -1390245819, 7, 1055976837, 1775126557, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, NULL, 'yu78', 244829661, -1362461264, 8, -904834265, -346339240, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
('t2__440f6d',)
('t2__440f6d',)
('t2__440f6d',)
('a2y',)
('a2y',)
('a2y',)
('t2__440f6d',)
('t2__440f6d',)
*/

-- Prediction Query
SELECT c.Currency FROM transactions_1k AS t INNER JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE t.Date = '2012-08-24' AND t.Amount = 548.4;

/*
Prediction Result:
*/