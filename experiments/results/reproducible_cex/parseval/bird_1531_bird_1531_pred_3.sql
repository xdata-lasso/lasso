-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '5k5swwqcgs', 't1__fff79f');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, '9n8', 't1__fff79f');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '4', 't1__fff79f');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-1, 'ryytoo3', '9hl7');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (0, 'klex14ji', '7zwau2dwyr');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2022-10-19', 'u7', 2, -734455130, 1744686505, -1633151678, -252690330, 797.015047);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2022-09-17', 'uzhsrwbbp6lu', 2, 1019800248, -1910425938, -845863578, -1610064545, 22.535764);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-29', 'rmdp', 2, 2026480202, -1576219117, -1823627488, -1209887326, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2020-01-23', '9000t5c4ec', 3, -1683203397, 528680845, -1585009206, -53231346, 816.814398);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2024-06-13', 'u', 3, -1179823637, 1119186446, 781505063, 418417917, 220.906948);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2020-12-02', 'qyp5s5bbp0', 3, 743312762, -1822992503, -868774469, -1068298341, 427.383654);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2022-12-09', '3pyu78d', 3, -977635379, 1661181156, -1372125820, -2031361952, 884.000446);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2022-09-10', 'qi2rkf9v', 3, 556727997, 1178000634, 1836127587, -1529584866, 755.698226);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2021-02-03', 'd21vy9uxj4hw', 3, -2050247126, -736979194, 2103044118, -1642259219, 109.083092);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2022-04-21', 'q', 3, -664193365, -1070063173, 555413010, 722884590, 635.267184);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2022-05-10', 'p', 3, -988981234, -841004020, -361507387, 401805964, 154.065416);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2022-12-06', 'n2f3dqv0g', 3, 1382410067, 1631231566, 172461907, 1606439408, 836.121091);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2025-03-14', 'bilyrkn', 3, -688098735, 1784916884, 37673509, 834709651, 418.948509);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2025-12-20', 'sww', 3, -1388029300, -566887085, 602161869, 1350414441, 987.646344);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483634, '2020-02-10', '7ryfdrz16n', 3, -1496556994, -2115841792, 1746373317, 1360271423, 488.601669);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483633, '2022-07-24', 'rg', 1, -1478247928, 1074760385, 1129658414, 1250290042, 100.07927);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2021-03-06', 'itsj3', 1, -491938169, -106471771, 1235416111, 1923912467, 571.595144);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483631, '2021-08-03', '3d', 1, -1826414375, 357330522, -683007527, 2035306060, 735.057703);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483630, '2024-02-23', 'afu5w1of7', 1, 76996700, -435350511, 1992637800, -820614248, 37.950999);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483629, '2023-06-03', 'mfg62g0v5q8q', 1, -1488156735, -1858644047, -1180042408, 199672698, 993.555996);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483628, '2025-11-04', 'v', 1, -866772222, -847293924, -2033879835, 1798111945, 322.910151);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483627, '2025-07-13', 'i36c4bf', 1, -1173368267, 382831862, -406331049, -461418236, 703.87087);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483626, '2024-05-20', 'o7w', 1, -542502665, 1999335832, -526612570, -546516406, 187.71278);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483625, '2023-01-12', '0oztdgj5i3lq', 1, 1816660482, -1212676731, 1692046802, -1300180872, 167.377262);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483624, '2025-07-11', 'qs27p2r94', 1, -1719383707, 1273687251, 333302050, 1162591638, 625.532672);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483623, '2020-01-11', 'jla', 1, 1919033056, -1428186898, -761353513, 362376128, 585.201826);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483622, '2022-03-08', '2ne578', 1, 1908593332, 697257217, -451030047, -2052653308, 543.387709);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483621, '2024-04-30', 'kv42q7', 1, -2060082151, -1122409769, 1849819405, -929383517, 13.328055);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483620, '2023-10-12', 'krpd', 1, -609553675, 989018473, -55494714, -1674145149, 554.705331);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483619, '2022-07-11', '05a9n0jxf', 1, -1165594842, -634585028, 1719800120, -210159774, 562.960947);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483618, '2020-03-13', '0', 1, 375841374, -1449226553, -225238282, -1898678660, 38.169466);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483617, '2022-01-03', '5amsorlwyngc', 1, -323362455, 453340472, 211603887, -413043724, 677.305163);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483616, '2024-10-21', 'yoeyo6l0hdt6', 1, 1435223075, 1617348603, -477129795, -1418927432, 904.57762);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483615, '2025-07-12', '1gwnlas6', 1, -2076274980, 1731324803, -1159083009, -1589605308, 437.428969);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483614, '2025-07-12', 'xih6', 1, -251205568, 287256667, 1614799674, 1083479253, 913.199755);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483613, '2022-08-11', 'aawg96aqb0tb', 1, -1216952047, -457901285, -2140923099, -841516418, 535.501742);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483612, '2025-06-14', 'cgumbc', 1, 1295379066, 1071401016, 40558455, 740386991, 843.866361);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483611, '2024-05-24', 'xw1rxe9yfk7', 1, -1046720861, 643589729, -1231488097, 956819642, 680.425625);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483610, '2024-04-04', 'dohvu06d', 1, -438741674, -154207334, 729449685, -1580984044, 422.698571);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483609, '2025-12-31', 'i2hy0', 1, 168442149, 1299171592, 2066302536, 24053253, 349.371383);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483608, '2022-11-11', 'xnjaby', 1, 462225708, 1528227252, -1277305894, -1659775598, 453.840746);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483607, '2022-09-22', '6sto1cj8sh5k', 1, 1106724223, 1966809332, 1487347213, 1328948152, 52.250567);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483606, '2021-08-21', 'gjac', 1, 973811121, 280292620, 620355627, -531872415, 5.194667);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483605, '2025-11-15', 'v4ygmayq3qdp', 1, -2082238979, -845136979, -1042976410, -1670945624, 487.287849);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483604, '2023-11-30', 'ic7', 1, 899787662, 594760660, 833568923, -384749431, 55.861048);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483603, '2022-02-24', 'sqtgelcuqb', 1, 1374676344, 238243966, -788896327, -1541581575, 862.602858);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_54cc53', 162.04354);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_507e73', 174.140432);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, '1', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'A', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, '!', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'b', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '!', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '3', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '"', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'C', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '.', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '[', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, 'E', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'e', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (0, '$', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (-1, '@', 0.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Price / T2.Amount), T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.CustomerID = (SELECT CustomerID FROM yearmonth ORDER BY Consumption DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1) GROUP BY T2.CustomerID, T1.Currency;

/*
Gold Result:
(1, 1.5215818008561369e-05, 't1__fff79f')
*/

-- Prediction Query
SELECT c.CustomerID, SUM(tx.Price) / SUM(tx.Amount) AS AveragePricePerItem, c.Currency FROM transactions_1k AS tx INNER JOIN customers AS c ON tx.CustomerID = c.CustomerID GROUP BY c.CustomerID, c.Currency ORDER BY SUM(tx.Amount) DESC, c.CustomerID NULLS LAST, AveragePricePerItem NULLS LAST, c.Currency NULLS LAST LIMIT 1;

/*
Prediction Result:
(3, 1.819124108638808e-05, 't1__fff79f')
*/