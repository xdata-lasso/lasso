-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2025-06-17', '5sw', 1258409369, -1981402255, 1, -890215420, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2021-02-11', 'u7vfe4hria2y', 1115440883, 1644814318, 1, 1465859724, -1349201381, 737.440743);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2023-10-03', 'l', -845863578, -1610064545, 1, 429706943, 462974032, 792.223623);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2022-08-20', 'siie', -45536098, 1861536320, 1, 44952191, 1151980946, 83.204633);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2020-01-23', '9000t5c4ec', -1683203397, 528680845, 1, -1585009206, -53231346, 816.814398);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2024-06-13', 'u', -1179823637, 1119186446, 1, 781505063, 418417917, 220.906948);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2020-12-02', 'qyp5s5bbp0', 743312762, -1822992503, 1, -868774469, -1068298341, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2024-10-16', 'ryytoo3', -1666765085, 1178636309, 1, -1390245819, 1055976837, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-10-22', 'ji7zwau2', 364869063, -953437896, 1, -1097120355, 244829661, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2022-01-18', 'sl0', -2031361952, 1649269347, 1, -1116181514, 1255852738, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2021-07-18', 'rkf9vqx5', 1836127587, -1529584866, 1, 1196308825, 910894705, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2025-01-26', 'vy9uxj4', -1612443122, -2050247126, 1, -736979194, 2103044118, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2021-04-26', 'gndqwnqc', 555413010, 722884590, NULL, 580968159, -1245312912, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2022-09-19', 'jtu0d', 401805964, -1485777725, NULL, -1255130038, -1762857309, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483634, '2020-08-04', 'qv0gcb98ozk', -155284187, 1686459626, NULL, -1554531873, 982314585, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2023-02-18', 'kn6vck6ah0f8', -1520489792, -658391922, 1, -1388029300, -566887085, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2025-11-20', '2fxa7ryfdrz', 61479715, -1496556994, 1, -2115841792, 1746373317, 3.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2020-09-12', 'h5ogrgjd8yz', 1250290042, -1717646459, -1696173285, 710458518, 678047687, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2021-09-30', 'ayxp1q43', 1235416111, 1923912467, 518609210, 1948383687, 1476361420, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2022-06-06', 'c68x8vacx', -1762140823, 1371234901, -290314193, 76996700, -435350511, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2025-11-01', 'ctdctmfg', -242584410, -698610044, -1021978385, 569007824, -1139855872, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (10, '2024-11-08', 'o22', 2004147439, -691774480, -1523347137, 1582582341, 453836040, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (11, '2021-03-15', 'bnou5zi36', 1944978593, 1722106924, -2072838897, -1173368267, 382831862, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (12, '2020-09-06', '7z2zezj', 1448731351, -604098478, 1248858185, -57705450, -915385605, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (13, '2020-05-15', 'r0oz', -870767087, -1699185893, 875300074, -1609653472, -1405314653, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (14, '2025-07-26', 'npi', -1300180872, -1125548818, 1497321728, -95808609, -244633520, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '2022-05-15', 'ajjla3okv8u', 618058035, 1553368934, -1252009958, 1908593332, 697257217, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (16, '2024-05-28', 'zzbe8yvkv', 318331233, -233617564, 79330142, 1735561423, 756202403, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (17, '2020-03-24', 'pmaus3au', -699574669, 274891948, 609771851, -1934017803, 1105964624, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, '2024-07-02', 'w5chn9mo705a', -1245584612, 1731843275, -582376271, -1165594842, -634585028, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '2024-06-14', 'o', 1010672881, -1197954156, -2019656607, 375841374, -1449226553, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT GasStationID FROM transactions_1k GROUP BY GasStationID ORDER BY SUM(Price) DESC, GasStationID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T1.GasStationID FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID GROUP BY T1.GasStationID ORDER BY SUM(T2.Price * T2.Amount) DESC, T1.GasStationID NULLS LAST LIMIT 1;

/*
Prediction Result:
*/