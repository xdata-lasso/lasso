-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -55602865, 'gs__93ec62', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483648, 1610062532, 'gs__93ec62', 'pgu7vfe4');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483646, 947159877, 'gs__93ec62', '5c4ec');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483645, 90119032, 'gs__93ec62', 'lex');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -1529584866, 'gs__93ec62', 'd2');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483644, 1675430660, 'gs__93ec62', 'y9uxj4');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483642, 638024588, 'gs__93ec62', '6vck6ah0f8js');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483641, -1888505890, 'gs__93ec62', 'z16nijjai5d');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 710458518, 'gs__93ec62', 'sj3ayxp1q430');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1010672881, 'obb0q0k', '2odwcl5a');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2021-05-05', 'ia2yp', -1670923962, 700293388, 906324270, 2, 1908028688, 994.117864);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2022-08-24', 'luhvdltti', -1364429300, -1257178728, 2, 2, 1236688122, 986.066566);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2020-07-11', 'posiie5unw6k', 1151980946, 1620389964, 2, 2, 546571701, 801.414196);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2021-06-11', 'gce376nium52', -443340271, 757448742, -1179823637, 2, 1119186446, 590.639932);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2023-02-21', 'qrofqyp5s5b', 2107872094, 882961052, 2, 2, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2020-11-05', 'tliqa1', 2074205376, 274769912, 2, 2, -188151580, 552.838162);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2024-10-22', 'ji7zwau2', 364869063, -953437896, -1097120355, 2, 244829661, 182.777264);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2023-03-31', '0b4', 1649269347, -1116181514, 2, 2, 1255852738, 137.842122);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2023-01-22', 'f9v', 556727997, 1178000634, 2, 2, 1836127587, 410.133844);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2021-05-25', 'bdvlph', -261132974, -1264842910, -1052964641, 2, -1245682094, 32.254574);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2024-02-11', '5hncprjtu0d', 401805964, -1485777725, 1, 2, -1255130038, 89.552801);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2020-08-04', 'qv0gcb98ozk', -155284187, 1686459626, 1, 2, -1554531873, 728.712934);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2023-11-21', 'lq7xb7', 602161869, 1350414441, 2094425101, 2, -961217731, 86.816079);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2021-05-12', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, 2, -1696173285, 127.371696);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483634, '2024-10-12', 'jh3den8c68', -683007527, 2035306060, 1523825314, 2, 2078438287, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483633, '2023-07-08', 'w1of77pz', 87529806, -1957268147, -1928431425, 2, 1303877941, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2022-04-02', 'g6', -242584410, -698610044, 2, 1, -1021978385, 632.482455);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483631, '2022-08-18', '1i', 1897687032, -241848752, 2, 1, 2004147439, 338.933701);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483630, '2021-08-18', 'ttg6', 1467355421, -1171104889, -29242208, 2, 1691780814, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483629, '2025-03-18', 'c4bfkfoac', -406331049, -461418236, -468701684, 2, 1448731351, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483628, '2025-11-13', 'wgxd5ysxcm', 1721638020, 983324983, 2, 2, 1269522000, 698.769833);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483627, '2023-05-02', 'g', -20116244, -176606723, 2, 2, -15162884, 811.930904);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483626, '2022-08-25', 'm5k', 1379859112, 195202164, 1817366143, 2, 1615073310, 628.658254);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483625, '2022-09-01', 'r94gth2m', 418247369, -1524425594, 2, 2, -1351793914, 462.366429);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483624, '2022-08-04', 'v8u', 618058035, 1553368934, 2, 2, -1252009958, 497.427028);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483623, '2025-11-10', 'lfvyz7zzb', 924693315, -705922211, 1043710187, 2, 318331233, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2024-12-30', '7sx58', 782684333, 681598285, 1, 2, 319284352, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2023-03-07', 'auvmkrpd', -609553675, 989018473, -55494714, 2, -1674145149, 1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2022-02-22', 'o705a9n0jxfo', -1793230843, -441521858, 4, 2, 2015094998, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('gs__93ec62',)
*/

-- Prediction Query
SELECT DISTINCT gs.country FROM gasstations AS gs INNER JOIN transactions_1k AS t ON gs.gasstationid = t.gasstationid WHERE t.productid = 2 AND t.price = (SELECT MAX(price) FROM transactions_1k WHERE productid = 2);

/*
Prediction Result:
*/