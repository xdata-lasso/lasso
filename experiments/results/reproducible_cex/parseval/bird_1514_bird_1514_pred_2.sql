-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 't2__2a4975');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'hria2ypuzhs', 't2__2a4975');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'bnp', 't2__2a4975');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '9n8', '4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'uzhs', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'dpos', 'ie5');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'ecigce376n', 'um5');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'qyp5s5bbp0', '2eutliqa11r');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, '9hl7', 'klex14ji');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-24', '16:25:00', 1, 247012447, -1980249628, -734455130, 1744686505, 483.665643);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-24', '16:25:00', 1, 700293388, 906324270, 1908028688, 2122220075, 749.826493);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-24', '16:25:00', 1, 13244799, -1659388584, 1526238907, -1377057208, 304.02808);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-24', '16:25:00', 3, 1236688122, 2087640001, 907682809, 2026480202, 133.007885);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-24', '16:25:00', 3, -1823627488, -1209887326, -1399556171, 1038707349, 587.783596);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2012-08-24', '16:25:00', 3, 1419861592, 700088193, 374105386, 1274489983, 128.76421);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-24', '16:25:00', 1, -1683203397, 528680845, -1585009206, -53231346, 816.814398);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-24', '16:25:00', 1, -443340271, 757448742, -1179823637, 1119186446, 590.639932);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2012-08-24', 't1__a19f05', 1, 781505063, 418417917, -1031969798, -1106983592, 938.694822);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2024-06-15', '16:25:00', 1, 902551284, 2107872094, 882961052, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, NULL, '16:25:00', 3, -55602865, -59984348, -664303813, -1022641847, 97.952323);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2024-06-15', 't1__cb09fc', 4, -734455130, 1744686505, -1633151678, -252690330, 797.015047);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, NULL, 't1__cb09fc', 5, -1377057208, -841692980, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2012-08-24', NULL, 6, -1209887326, -1399556171, 1038707349, 1419861592, 663.001988);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2024-06-15', NULL, 7, 742285925, -747753377, 902887186, -967741825, 680.514642);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, NULL, NULL, 8, 2137741668, -525979501, 1898504886, 624571013, 882.985782);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Currency FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Time = '16:25:00' AND T1.Date = '2012-08-24';

/*
Prediction Result:
('t2__2a4975',)
('t2__2a4975',)
('t2__2a4975',)
('4',)
('4',)
('4',)
('t2__2a4975',)
('t2__2a4975',)
*/