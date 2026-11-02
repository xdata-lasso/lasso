-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 'cus_3c8570');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'hria2ypuzhs', 'cus_3c8570');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '5k5swwqcgs', '9n8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'e4', 'hria2ypuzhs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'luhvdltti', 'bnp');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, '5u', 'w6kl');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, '4', 'ecigce376n');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (8, 'o4nrqr', 'fqyp');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'value', NULL);

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-24', '16:25:00', 1, 247012447, -1980249628, -734455130, 1744686505, 483.665643);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-24', '16:25:00', 2, 700293388, 906324270, 1908028688, 2122220075, 749.826493);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-24', '16:25:00', 2, 13244799, -1659388584, 1526238907, -1377057208, 304.02808);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-24', '16:25:00', 3, -1364429300, -1257178728, 1236688122, 2087640001, 666.330692);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-24', '16:25:00', 3, 907682809, 2026480202, -1576219117, -1823627488, 327.753528);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2012-08-24', '16:25:00', 3, -1209887326, -1399556171, 1038707349, 1419861592, 663.001988);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-24', '16:25:00', 1, 374105386, 1274489983, -1683203397, 528680845, 467.07027);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-24', '16:25:00', 1, -1585009206, -53231346, -443340271, 757448742, 225.300904);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-06-15', '16:25:00', 1, 1119186446, 781505063, 418417917, -1031969798, 242.260296);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2012-08-24', 'tra_b3bf39', 1, 1884179925, 902551284, 2107872094, 882961052, 673.065986);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2012-08-24', NULL, 3, 1610062532, -106629402, 1871297066, 809183447, 520.784135);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2024-06-15', 'tra_085e91', 4, 700293388, 906324270, 1908028688, 2122220075, 749.826493);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2024-06-15', NULL, 5, 1236688122, 2087640001, 907682809, 2026480202, 133.007885);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, NULL, '16:25:00', 6, 1620389964, 546571701, 947159877, 1990080517, 827.854302);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, NULL, 'tra_085e91', 7, 1313172851, -761141909, 283598170, 742285925, 21.917736);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, NULL, NULL, 8, -921187550, -2070843029, 328305758, -751275471, 186.190286);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (10, '2012-08-24', '16:25:00', 9, -55602865, -59984348, -664303813, -1022641847, 97.952323);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Currency FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Time = '16:25:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT customers.Currency FROM customers INNER JOIN transactions_1k ON customers.CustomerID = transactions_1k.CustomerID WHERE transactions_1k.Date = '2012-08-24' AND transactions_1k.Time = '16:25:00';

/*
Prediction Result:
('cus_3c8570',)
('cus_3c8570',)
('cus_3c8570',)
('9n8',)
('9n8',)
('9n8',)
('cus_3c8570',)
('cus_3c8570',)
(None,)
*/