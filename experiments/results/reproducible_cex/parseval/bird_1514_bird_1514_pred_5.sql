-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 't3__c06a30');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'dlttil', 't3__c06a30');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'n', 't3__c06a30');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'mdpos', 'ie5');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'zbuo4nrq', 'rofqyp5s5b');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, '9hl7', 'klex14ji');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'jsl', 'b4yp5qi');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'vy9uxj4', 'wb');

-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, 247012447, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 462974032, 'posiie5unw6k', 'fa9');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -1833165707, '6nium52zb', 'uo4nrqrofqy');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -1022641847, 'sk', '9n8c4pgu7v');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1072996612, 'luhvdltti', 'bnp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1419861592, '4ecigce376n', 'um5');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, -1822992503, 'liqa1', 'ryytoo3');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 364869063, 'q13py', '78d99r');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 556727997, '8pz0f8je', 'd2');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-24', '16:25:00', 1, 1644814318, 1, 1465859724, -1349201381, 737.440743);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-24', '16:25:00', 2, 1620389964, 1, 546571701, 947159877, 963.351729);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-24', '16:25:00', 3, 1408123494, 1, -1964997180, 1149850321, 44.682291);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-24', '16:25:00', 1, -1106983592, 3, 1884179925, 902551284, 22.720462);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-24', '16:25:00', 3, 2107872094, 1, 882961052, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2012-08-24', '16:25:00', 1, -1822992503, 3, -868774469, -1068298341, 427.383654);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2012-08-24', '16:25:00', 3, -314162272, 1, 2137741668, -525979501, 668.928822);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2012-08-24', '16:25:00', 1, 1898504886, 3, 624571013, 1644911394, 228.583847);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2012-08-24', '16:25:00', 3, -1666765085, 1, 1178636309, -1390245819, 763.856372);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-24', '16:25:00', 1, 1055976837, 1, 1775126557, -74849714, 133.223471);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-24', '16:25:00', 1, 105869088, 1, -2081315180, 1909986641, 845.831524);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2024-06-15', '16:25:00', 1, -511185946, 1, -1021749117, 392822403, 998.887019);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2012-08-24', 't1__c4a414', 1, -533293970, 1, 176380444, -977635379, 145.402595);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2012-08-24', NULL, 3, -55602865, 3, -59984348, -664303813, 833.684115);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2024-06-15', 't1__60be52', 4, 700293388, 4, 906324270, 1908028688, 994.117864);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2024-06-15', NULL, 5, -1209887326, 5, -1399556171, 1038707349, 587.783596);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, NULL, '16:25:00', 6, 2107872094, 6, 882961052, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, NULL, 't1__60be52', 7, -453362185, 7, 481163439, 2123196517, 920.013763);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, NULL, NULL, 8, -227162283, 8, 2056419640, 222415430, 263.638479);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
('t3__c06a30',)
('t3__c06a30',)
('hria2ypuzhs',)
('t3__c06a30',)
('hria2ypuzhs',)
('t3__c06a30',)
('hria2ypuzhs',)
('t3__c06a30',)
('hria2ypuzhs',)
('t3__c06a30',)
('t3__c06a30',)
*/

-- Prediction Query
SELECT DISTINCT customers.currency FROM transactions_1k INNER JOIN customers ON transactions_1k.customerid = customers.customerid WHERE transactions_1k.date = '2012-08-24' AND transactions_1k.time = '16:25:00';

/*
Prediction Result:
('t3__c06a30',)
('hria2ypuzhs',)
*/