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

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2020-12-02', 'qyp5s5bbp0', 743312762, -1822992503, 0, -868774469, -1068298341, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2024-10-16', 'ryytoo3', -1666765085, 1178636309, 0, -1390245819, 1055976837, -1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-10-22', 'ji7zwau2', 364869063, -953437896, 0, -1097120355, 244829661, 182.777264);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2023-03-31', '0b4', 1649269347, -1116181514, -1, 1255852738, -1555456236, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2023-01-22', 'f9v', 556727997, 1178000634, -1, 1836127587, -1529584866, -1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2021-02-03', 'd21vy9uxj4hw', -2050247126, -736979194, -1, 2103044118, -1642259219, 109.083092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2022-04-21', 'q', -664193365, -1070063173, 0, 555413010, 722884590, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2021-04-09', 'cprj', -841004020, -361507387, 0, 401805964, -1485777725, -1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483634, '2022-12-06', 'n2f3dqv0g', 1382410067, 1631231566, 0, 172461907, 1606439408, 836.121091);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483633, '2025-03-14', 'bilyrkn', -688098735, 1784916884, 2, 37673509, 834709651, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2024-09-12', '8j', -932772113, -639539893, 2, 1255343543, -541746689, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483631, '2025-11-03', 'yfdrz', 61479715, -1496556994, 3, -2115841792, 1746373317, 3.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483630, '2020-09-12', 'h5ogrgjd8yz', 1250290042, -1717646459, 2, -1696173285, 710458518, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483629, '2023-04-01', '3ay', -598313376, 1972233925, 2, 1792827279, 804529642, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483628, '2025-02-15', '1jh3den', 357330522, -683007527, 3, 2035306060, 1523825314, 3.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483627, '2021-01-02', '5w1of7', 76996700, -435350511, 2, 1992637800, -820614248, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483626, '2020-06-04', 'mfg62', -1744557630, 1870300798, 2, 820970595, 1421303999, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483625, '2020-08-09', 'jpe1io22785', 2119806856, -1962347906, 3, -866772222, -847293924, 3.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483624, '2025-09-24', 'n', 1798111945, 944975670, 2, -1575410149, -68044929, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483623, '2020-12-19', 'foa', 382831862, -406331049, 2, -461418236, -468701684, 2.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483622, '2022-08-08', 'wgxd5ysxc', -405743609, -1935752926, 3, -20116244, -176606723, 3.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483621, '2022-12-17', '5lnpim5k58qs', 1615073310, 1055237066, 1, 988954859, -1719383707, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483620, '2021-04-23', '2mnajjla3o', -1428186898, -761353513, 1, 362376128, -1311735207, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483619, '2025-01-03', 'e578', 1908593332, 697257217, 1, -451030047, -2052653308, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483618, '2024-04-30', 'kv42q7', -2060082151, -1122409769, NULL, 1849819405, -929383517, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483617, '2020-02-24', 'vmkrpd', -609553675, 989018473, NULL, -55494714, -1674145149, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483616, '2022-02-22', 'o705a9n0jxfo', -1793230843, -441521858, NULL, 2015094998, 1010672881, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483615, '2024-06-24', 'obb0q0k32o', -1898678660, 440115543, 1, 292557306, 709097796, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483614, '2023-01-14', 'wyn', 1953495465, -1960313034, 1, 681061317, 1935791961, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483613, '2021-07-24', 'zgk1yoeyo6l0', -1614619556, 1435223075, 1, 1617348603, -477129795, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT GasStationID FROM transactions_1k GROUP BY GasStationID ORDER BY SUM(Price) DESC, GasStationID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T.GasStationID FROM (SELECT T1.GasStationID, SUM(T1.Amount * T1.Price) AS Revenue FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID GROUP BY T1.GasStationID ORDER BY Revenue DESC, T1.GasStationID NULLS LAST LIMIT 1) AS T;

/*
Prediction Result:
*/