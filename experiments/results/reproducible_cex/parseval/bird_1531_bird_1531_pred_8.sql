-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '5k5swwqcgs', 't1__9ee7e7');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '9n8', 't1__9ee7e7');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '4', 't1__9ee7e7');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (0, '79fjgq8', 'n2f3dqv0gcb9');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2022-10-19', 'u7', 2, -734455130, 1744686505, -1633151678, -252690330, 797.015047);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2022-09-17', 'uzhsrwbbp6lu', 2, 1019800248, -1910425938, -845863578, -1610064545, 22.535764);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-29', 'rmdp', 2, 2026480202, -1576219117, -1823627488, -1209887326, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2020-01-23', '9000t5c4ec', 2, -1683203397, 528680845, -1585009206, -53231346, 816.814398);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2024-06-13', 'u', 2, -1179823637, 1119186446, 781505063, 418417917, 220.906948);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2020-12-02', 'qyp5s5bbp0', 2, 743312762, -1822992503, -868774469, -1068298341, 427.383654);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2024-10-14', 'yytoo', 2, 1644911394, -1666765085, 1178636309, -1390245819, 763.856372);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2024-03-14', '4ji7zwa', 2, 2123196517, 364869063, -953437896, -1097120355, 326.912005);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2020-07-21', '9rljsl0b4', 2, 1649269347, -1116181514, 1255852738, -1555456236, 272.94048);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2021-01-15', 'vqx58pz0f', 2, 176555546, -1937207087, 1675430660, -688509700, 654.149);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2023-07-16', 'j4hwbd', 2, -736979194, 2103044118, -1642259219, 1298861365, 58.749749);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2022-11-09', 'nqcx5h', 2, -1245312912, 1575412235, -988981234, -841004020, 415.830002);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2022-06-25', 'k3zbily', 2, 638024588, -688098735, 1784916884, 37673509, 591.134092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2021-03-28', 'f8jswwl', 2, 1255343543, -541746689, 1294666887, -515895469, 832.28682);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483634, '2023-02-06', 'z16nijjai5d', 2, -1625552518, -1738458256, -1714354341, -458359144, 639.801051);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483633, '2020-02-11', 'fgogritsj3ay', 1, -598313376, 1972233925, 1792827279, 804529642, 457.141778);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2024-08-06', 'jh3den8', 1, 195720193, 1774087382, 1732258051, -1762140823, 819.265503);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483631, '2023-12-23', '1of77pzo72c', 1, -820614248, 481546706, -1784554553, -242584410, 415.494881);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483630, '2023-10-13', 'q8qdjpe1', 1, -1180042408, 199672698, 2119806856, -1962347906, 298.188866);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483629, '2022-09-27', 'ttg6bnou5zi3', 1, -68044929, -1776877925, 1201273976, 1923659053, 12.330671);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483628, '2020-07-07', '0', 1, 76987628, -253138337, 641521863, 304189298, 108.948237);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483627, '2024-03-10', '5', 1, -526612570, -546516406, -405743609, -1935752926, 145.027285);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483626, '2025-07-21', '3lq', 1, 1816660482, -1212676731, 1692046802, -1300180872, 167.377262);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483625, '2025-07-11', 'qs27p2r94', 1, -1719383707, 1273687251, 333302050, 1162591638, 625.532672);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483624, '2020-01-11', 'jla', 1, 1919033056, -1428186898, -761353513, 362376128, 585.201826);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483623, '2022-03-08', '2ne578', 1, 1908593332, 697257217, -451030047, -2052653308, 543.387709);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483622, '2024-04-30', 'kv42q7', 1, -2060082151, -1122409769, 1849819405, -929383517, 13.328055);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483621, '2023-10-12', 'krpd', 1, -609553675, 989018473, -55494714, -1674145149, 554.705331);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483620, '2022-07-11', '05a9n0jxf', 1, -1165594842, -634585028, 1719800120, -210159774, 562.960947);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483619, '2020-03-13', '0', 1, 375841374, -1449226553, -225238282, -1898678660, 38.169466);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483618, '2022-01-03', '5amsorlwyngc', 1, -323362455, 453340472, 211603887, -413043724, 677.305163);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483617, '2024-10-21', 'yoeyo6l0hdt6', 1, 1435223075, 1617348603, -477129795, -1418927432, 904.57762);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483616, '2025-07-12', '1gwnlas6', 1, -2076274980, 1731324803, -1159083009, -1589605308, 437.428969);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483615, '2025-07-12', 'xih6', 1, -251205568, 287256667, 1614799674, 1083479253, 913.199755);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483614, '2022-08-11', 'aawg96aqb0tb', 1, -1216952047, -457901285, -2140923099, -841516418, 535.501742);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483613, '2025-06-14', 'cgumbc', 1, 1295379066, 1071401016, 40558455, 740386991, 843.866361);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483612, '2024-05-24', 'xw1rxe9yfk7', 1, -1046720861, 643589729, -1231488097, 956819642, 680.425625);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483611, '2024-04-04', 'dohvu06d', 1, -438741674, -154207334, 729449685, -1580984044, 422.698571);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483610, '2025-12-31', 'i2hy0', 1, 168442149, 1299171592, 2066302536, 24053253, 349.371383);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483609, '2022-11-11', 'xnjaby', 1, 462225708, 1528227252, -1277305894, -1659775598, 453.840746);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483608, '2022-09-22', '6sto1cj8sh5k', 1, 1106724223, 1966809332, 1487347213, 1328948152, 52.250567);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483607, '2021-08-21', 'gjac', 1, 973811121, 280292620, 620355627, -531872415, 5.194667);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483606, '2025-11-15', 'v4ygmayq3qdp', 1, -2082238979, -845136979, -1042976410, -1670945624, 487.287849);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483605, '2023-11-30', 'ic7', 1, 899787662, 594760660, 833568923, -384749431, 55.861048);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483604, '2022-02-24', 'sqtgelcuqb', 1, 1374676344, 238243966, -788896327, -1541581575, 862.602858);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483603, '2024-10-03', 'uik1y', 1, 775289854, -2052350430, 166124233, 1862197286, 770.955182);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_ec2d30', 162.04354);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_f43ec3', 174.140432);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'yea_f43ec3', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Price / T2.Amount), T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.CustomerID = (SELECT CustomerID FROM yearmonth ORDER BY Consumption DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1) GROUP BY T2.CustomerID, T1.Currency;

/*
Gold Result:
(1, 1.0179378567057266e-05, 't1__9ee7e7')
*/

-- Prediction Query
SELECT t.CustomerID, (SUM(t.Price) / SUM(t.Amount)) AS average_price_per_item, c.Currency FROM transactions_1k AS t JOIN customers AS c ON t.CustomerID = c.CustomerID WHERE t.CustomerID = (SELECT CustomerID FROM transactions_1k GROUP BY CustomerID ORDER BY SUM(Price) DESC, CustomerID NULLS LAST LIMIT 1) GROUP BY t.CustomerID, c.Currency;

/*
Prediction Result:
(1, -9.170396934455831e-07, 't1__9ee7e7')
*/