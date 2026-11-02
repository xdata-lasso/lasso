-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 't2__af91b5', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1268590800, 't2__af91b5', 'puzhsrw');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 1908028688, 't2__af91b5', 'p');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 374105386, 't2__af91b5', 'cigce376nium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, -1633151678, 'a2y', 'uzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1236688122, 'dpos', 'ie5');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 1274489983, 'gce', '76nium52');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 328305758, 'tliqa1', 'ryytoo3');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, -74849714, '7zw', 'au2dwyrq13');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 1692174491, 'qi2rkf9v', 'x58pz');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-24', '9n8c4pgu7v', -1865039888, 1160656988, 1, -992890117, 1914020640, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-24', 'luhvdltti', -1364429300, -1257178728, 2, 1236688122, 2087640001, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-24', 'dposiie5unw', -1399556171, 1038707349, 3, 1419861592, 700088193, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-24', '52zbuo4nrq', 418417917, -1031969798, 2, -1106983592, 1884179925, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-24', 'bbp02eut', -1347802441, 1673584235, 2, -2118135981, 2074205376, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2012-08-24', 'yytoo', 1644911394, -1666765085, 2, 1178636309, -1390245819, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-24', 'x14ji7zwau2d', 1485335077, -511185946, 1, -1021749117, 392822403, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-24', 'yu78', 244829661, -1362461264, 1, -904834265, -346339240, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-06-15', 'yp5qi2rk', -705985602, 537874887, 1, -461695645, 836513442, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2012-08-24', '8jegd21vy9ux', -1492524358, -1612443122, 1, -2050247126, -736979194, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2012-08-24', '5k5swwqcgs', 247012447, -1980249628, 4, -734455130, 1744686505, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2024-06-15', 'rwbbp6luhvd', -1377057208, -841692980, 5, -1364429300, -1257178728, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2024-06-15', 'nw6klf', 1038707349, 1419861592, 6, 700088193, 374105386, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, NULL, 'zbuo4nrqrof', 373262291, -472966518, 7, -921187550, -2070843029, 548.4);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, NULL, '9hl7', 1178636309, -1390245819, 8, 1055976837, 1775126557, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, NULL, 'yu78', 244829661, -1362461264, 9, -904834265, -346339240, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
('t2__af91b5',)
('t2__af91b5',)
('t2__af91b5',)
('t2__af91b5',)
('t2__af91b5',)
('t2__af91b5',)
('t2__af91b5',)
('t2__af91b5',)
*/

-- Prediction Query
SELECT DISTINCT customers.segment FROM customers INNER JOIN transactions_1k ON customers.customerid = transactions_1k.customerid WHERE STRFTIME('%Y-%m-%d', transactions_1k.date) = '2012-08-24' AND transactions_1k.price = 548.4;

/*
Prediction Result:
*/