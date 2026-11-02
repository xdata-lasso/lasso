-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-25', '5k5swwqcgs', 1, 247012447, -1980249628, -734455130, 1744686505, 483.665643);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-25', 'hria2ypuzhs', 1, 700293388, 906324270, 1908028688, 2122220075, 749.826493);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-25', 'luhvdltti', 1, -1364429300, -1257178728, 1236688122, 2087640001, 666.330692);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-25', 'p', 1, 2026480202, -1576219117, -1823627488, -1209887326, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-25', 'lfa', 1, 1419861592, 700088193, 374105386, 1274489983, 128.76421);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-25', 'gce376nium', 1, 283598170, 742285925, -747753377, 902887186, 979.158161);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2024-06-15', 'rofqy', 1, -1106983592, 1884179925, 902551284, 2107872094, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2024-06-15', '02eutliqa11r', 1, 2137741668, -525979501, 1898504886, 624571013, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-06-15', 'o9hl72kl', 1, -305670381, -1525670226, -453362185, 481163439, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2012-08-25', '2dwyrq', 1, -1097120355, 244829661, -1362461264, -904834265, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2012-08-25', 'b4yp5qi', 1, -227162283, 2056419640, 222415430, 556727997, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2012-08-25', '8pz0f8je', 1, 1196308825, 910894705, -283454505, 233994589, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2012-08-25', 'j4hwbd', NULL, -736979194, 2103044118, -1642259219, 1298861365, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2012-08-25', 'q', NULL, -664193365, -1070063173, 555413010, 722884590, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483634, '2012-08-25', 'hncprjtu0dz', NULL, -1748371085, -1742081330, 894242932, -211209314, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483633, '2012-08-25', 'dqv0gcb9', 1, 172461907, 1606439408, 1443629118, -155284187, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2012-08-25', 'i', 1, -512640349, 1038566008, 32204797, -1672720816, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483631, '2012-08-25', '8j', 1, -932772113, -639539893, 1255343543, -541746689, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2012-08-25', '7ryfdrz16n', 1, -1496556994, -2115841792, 1746373317, 1360271423, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2012-08-25', 'ogrgjd8y', 1, 1129658414, 1250290042, -1717646459, -1696173285, 3.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2012-08-25', 'tsj', -197933860, 2111987706, -598313376, 1972233925, 1792827279, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2012-08-25', '4301jh3den8', 195720193, 1774087382, 1732258051, -1762140823, 1371234901, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2012-08-25', '1of77p', -435350511, 1992637800, -820614248, 481546706, -1784554553, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2012-08-25', '2g0v5q8qd', 569007824, -1139855872, -288338724, 1897687032, -241848752, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (10, '2012-08-25', '8507cvtjp', 1582582341, 453836040, 1467355421, -1171104889, -29242208, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (11, '2012-08-25', '36c', 1722106924, -2072838897, -1173368267, 382831862, -406331049, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (12, '2012-08-25', 'ezjo7wg', 1248858185, -57705450, -915385605, -2005628382, 1721638020, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (13, '2012-08-25', '0oztdgj5i3lq', 1816660482, -1212676731, 1692046802, -1300180872, -1125548818, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (14, '2012-08-25', '94gth', 333302050, 1162591638, -2136247961, -1478011227, -2096405521, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '2012-08-25', 'okv8uttmu2', -1252009958, 1908593332, 697257217, -451030047, -2052653308, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-25' GROUP BY CustomerID ORDER BY SUM(Price) DESC, CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25' GROUP BY T1.CustomerID ORDER BY SUM(T1.Amount) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Prediction Result:
*/