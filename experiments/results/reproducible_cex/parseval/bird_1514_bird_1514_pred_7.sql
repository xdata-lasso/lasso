-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 'cus_df921e');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'hria2ypuzhs', 'cus_df921e');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'rwbbp6luhvd', 'cus_df921e');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'nw6klf', 'cus_df921e');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, '9n8', '4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'uzhs', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'dpos', 'ie5');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'ecigce376n', 'um5');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'qyp5s5bbp0', '2eutliqa11r');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, '9hl7', 'klex14ji');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-24', '16:25:00', 1, 247012447, -1980249628, -734455130, 1744686505, 483.665643);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-24', '16:25:00', 2, -1377057208, -841692980, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-24', '16:25:00', 3, 2087640001, 907682809, 2026480202, -1576219117, 75.403642);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-24', '16:25:00', 2, 1038707349, 1419861592, 700088193, 374105386, 950.466571);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-24', '16:25:00', 2, 1274489983, -1683203397, 528680845, -1585009206, 191.847248);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2012-08-24', '16:25:00', 2, -53231346, -443340271, 757448742, -1179823637, 760.580899);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-24', '16:25:00', 1, 781505063, 418417917, -1031969798, -1106983592, 938.694822);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-24', '16:25:00', 1, 902551284, 2107872094, 882961052, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2012-08-24', 'tra_a100f2', 1, -1822992503, -868774469, -1068298341, -314162272, 997.73177);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2024-06-15', '16:25:00', 1, -525979501, 1898504886, 624571013, 1644911394, 228.583847);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, NULL, '16:25:00', 4, -55602865, -59984348, -664303813, -1022641847, 97.952323);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2024-06-15', 'tra_b9917c', 5, -734455130, 1744686505, -1633151678, -252690330, 797.015047);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, NULL, 'tra_b9917c', 6, -1377057208, -841692980, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2012-08-24', NULL, 7, -1209887326, -1399556171, 1038707349, 1419861592, 663.001988);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2024-06-15', NULL, 8, 742285925, -747753377, 902887186, -967741825, 680.514642);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, NULL, NULL, 9, 2137741668, -525979501, 1898504886, 624571013, 882.985782);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT "customers"."currency" FROM "transactions_1k" INNER JOIN "customers" ON "transactions_1k"."customerid" = "customers"."customerid" WHERE "transactions_1k"."time" = '16:25:00' AND "transactions_1k"."date" = '2012-08-24';

/*
Prediction Result:
('cus_df921e',)
('cus_df921e',)
('cus_df921e',)
('cus_df921e',)
('cus_df921e',)
('cus_df921e',)
('cus_df921e',)
('cus_df921e',)
*/