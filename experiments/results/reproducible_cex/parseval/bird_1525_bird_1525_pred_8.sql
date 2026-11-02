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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'zhsrwb', 'EUR');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-25', '9n8', 1610062532, -106629402, 1871297066, 809183447, 89267185, 86.520366);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-25', '4h', 1, -992890117, 1914020640, 1268590800, 1219478689, 718.397869);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-25', 'p', 13244799, -1659388584, 1526238907, -1377057208, -841692980, 182.319045);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-25', 'nprmdposii', 2, -1823627488, -1209887326, -1399556171, 1038707349, 587.783596);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2012-08-25', '000t5c4ec', -1683203397, 528680845, -1585009206, -53231346, -443340271, 676.357279);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2012-08-25', '4nrq', 2, 418417917, -1031969798, -1106983592, 1884179925, 499.570479);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2012-08-25', 'bbp02eutliqa', -314162272, 2137741668, -525979501, 1898504886, 624571013, 882.985782);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2012-08-25', '9hl7', 2, 1178636309, -1390245819, 1055976837, 1775126557, 482.572691);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2012-08-25', '7zw', 481163439, 2123196517, 364869063, -953437896, -1097120355, 326.912005);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2012-08-25', 'd99rljsl0', 2, -2031361952, 1649269347, -1116181514, 1255852738, 137.842122);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2012-08-25', 'kf9vq', 537874887, -461695645, 836513442, 176555546, -1937207087, 890.091601);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-25', 'y9uxj4', 1, -1612443122, -2050247126, -736979194, 2103044118, 705.754562);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-25', '2g', 1, -1264842910, -1052964641, -1245682094, -1660358170, 41.944398);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2012-08-25', 'rjtu', -361507387, 401805964, -1485777725, -1255130038, -1762857309, 687.701166);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483634, '2012-08-25', 'qv0gcb98ozk', -155284187, 1686459626, -1554531873, 982314585, 638024588, 692.775559);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483633, '2012-08-25', 'ck6ah0', -1520489792, -658391922, -1388029300, -566887085, 602161869, 814.417862);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2012-08-25', 'a7ryfd', 564390026, -1259474148, 2011234363, -1483100200, -7597509, 651.586084);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483631, '2012-08-25', '5o', 1, 1449284300, -977470238, -1478247928, 1074760385, 763.019095);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483630, '2012-08-25', '1afgo', -1696173285, 710458518, 678047687, -1478134144, -491938169, 239.245131);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483629, '2024-06-15', 'q4301jh', 1, -163600466, -1826414375, 357330522, -683007527, 757.137864);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483628, '2012-08-25', 'x', -1762140823, 1371234901, -290314193, 76996700, -435350511, 689.065203);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483627, '2012-08-25', '72ctdctmfg62', 1, -1744557630, 1870300798, 820970595, 1421303999, 53.966914);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483626, NULL, 'pe1', -1180042408, 199672698, 2119806856, -1962347906, -866772222, 244.215606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483625, NULL, 'ttg6bnou5zi3', -68044929, -1776877925, 1201273976, 1923659053, -1950324754, 992.626961);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483624, '2012-08-25', '7z2zezjo7wg', 1248858185, -57705450, -915385605, -2005628382, 1721638020, 728.948186);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483623, '2012-08-25', 'ztdg', 1, -20116244, -176606723, -15162884, 1339733032, 236.262879);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(DISTINCT T1."customerid") AS REAL) * 100 / (SELECT COUNT(DISTINCT "customerid") FROM "transactions_1k" WHERE "date" = '2012-08-25') FROM "transactions_1k" AS T1 INNER JOIN "customers" AS T2 ON T1."customerid" = T2."customerid" WHERE T2."currency" = 'EUR' AND T1."date" = '2012-08-25';

/*
Prediction Result:
(6.666666666666667,)
*/