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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'e4', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483646, '2eutliqa11r', 'c_s_518054');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483645, 'ji7zwau2', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483644, 'p5qi2rk', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (4, 'luhvdltti', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (5, 'bnp', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '9000t5c4ec', 'EUR');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (6, 'rqro', 'c_s_9c8ab8');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (7, 'ryytoo3', 'c_s_9c8ab8');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-25', '9n8', 1, 1610062532, -106629402, 1871297066, 809183447, 520.784135);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-25', 'hria2ypuzhs', 3, 700293388, 906324270, 1908028688, 2122220075, 749.826493);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-25', 'luhvdltti', 3, -1364429300, -1257178728, 1236688122, 2087640001, 666.330692);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-25', 'p', 3, 2026480202, -1576219117, -1823627488, -1209887326, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-25', 'lfa', 3, 1419861592, 700088193, 374105386, 1274489983, 128.76421);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-25', 'gce376nium', 1, 283598170, 742285925, -747753377, 902887186, 979.158161);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-25', 'rofqy', 1, -1106983592, 1884179925, 902551284, 2107872094, 705.580387);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2012-08-25', 'ytoo3o9', 1, -1666765085, 1178636309, -1390245819, 1055976837, 913.303855);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-06-15', 'dwyrq13pyu78', 1, 244829661, -1362461264, -904834265, -346339240, 470.165282);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2012-08-25', '9v', 1, 556727997, 1178000634, 1836127587, -1529584866, 755.698226);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2012-08-25', '5k5swwqcgs', 4, 247012447, -1980249628, -734455130, 1744686505, 483.665643);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2012-08-25', 'hria2ypuzhs', 4, 700293388, 906324270, 1908028688, 2122220075, 749.826493);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, NULL, 'mdpos', 3, -1576219117, -1823627488, -1209887326, -1399556171, 741.842896);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2012-08-25', 'gce', 6, -1585009206, -53231346, -443340271, 757448742, 225.300904);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2024-06-15', 'fqyp5s5bbp0', 7, 743312762, -1822992503, -868774469, -1068298341, 427.383654);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(91.66666666666667,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT t.CustomerID) AS REAL) * 100.0 / CAST((SELECT COUNT(DISTINCT CustomerID) FROM customers) AS REAL)) AS percentage FROM transactions_1k AS t JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'EUR' AND t.Date = '2012-08-25';

/*
Prediction Result:
(30.0,)
*/