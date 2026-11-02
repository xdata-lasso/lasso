-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '5k5swwqcgs', 't1__d9c6c9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483648, '9n8', 't1__d9c6c9');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'a9000t5c4eci', 't1__d9c6c9');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2020-06-08', 'pgu7vfe4', 1, 1160656988, -992890117, 1914020640, 1268590800, 378.476082);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2022-09-17', 'uzhsrwbbp6lu', 1, 1019800248, -1910425938, -845863578, -1610064545, 22.535764);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-29', 'rmdp', 1, 2026480202, -1576219117, -1823627488, -1209887326, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2021-03-18', 'e', 3, -1585009206, -53231346, -443340271, 757448742, 225.300904);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2022-04-13', 'rqrofqyp5s', 3, 902551284, 2107872094, 882961052, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2020-11-05', 'tliqa1', 3, 2074205376, 274769912, -188151580, 226938182, 187.343342);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2025-11-03', 'klex14ji', 3, -453362185, 481163439, 2123196517, 364869063, 278.010437);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2024-11-10', '3pyu78d99r', 3, -1362461264, -904834265, -346339240, 1692174491, 495.297639);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2022-12-05', '2rk', 3, -705985602, 537874887, -461695645, 836513442, 707.476301);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2021-08-12', 'gd', 3, -283454505, 233994589, 1442655647, -87647544, 353.366837);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2020-07-26', 'lph2gn', 3, 1968874827, -664193365, -1070063173, 555413010, 668.309685);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2021-04-09', 'cprj', 3, -841004020, -361507387, 401805964, -1485777725, 261.415754);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2022-05-01', 'f3dqv0gc', 3, 1631231566, 172461907, 1606439408, 1443629118, 463.845085);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483635, '2020-03-07', 'lyr', 3, 1038566008, 32204797, -1672720816, -1520489792, 346.706184);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483634, '2021-12-25', '7xb72', 3, 1350414441, 2094425101, -961217731, -1888505890, 680.944245);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483633, '2024-11-10', '6nijjai5dh', 1, 1583472758, 1449284300, -977470238, -1478247928, 917.457483);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483632, '2024-05-09', 't1afgog', 1, -946046410, -902895762, -197933860, 2111987706, 360.694313);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483631, '2024-09-24', '4301j', 1, 1948383687, 1476361420, 195720193, 1774087382, 13.875982);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483630, '2020-06-09', 'x7afu5w1of77', 1, -1099855564, 87529806, -1957268147, -1928431425, 803.582738);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483629, '2022-04-02', 'g6', 1, -242584410, -698610044, -1021978385, 569007824, 234.606624);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483628, '2024-11-08', 'o22', 1, 2004147439, -691774480, -1523347137, 1582582341, 605.666938);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483627, '2021-03-15', 'bnou5zi36', 1, 1944978593, 1722106924, -2072838897, -1173368267, 707.057079);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483626, '2020-07-07', '0', 1, 76987628, -253138337, 641521863, 304189298, 108.948237);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483625, '2024-03-10', '5', 1, -526612570, -546516406, -405743609, -1935752926, 145.027285);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483624, '2025-07-21', '3lq', 1, 1816660482, -1212676731, 1692046802, -1300180872, 167.377262);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483623, '2025-07-11', 'qs27p2r94', 1, -1719383707, 1273687251, 333302050, 1162591638, 625.532672);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483622, '2020-01-11', 'jla', 1, 1919033056, -1428186898, -761353513, 362376128, 585.201826);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483621, '2022-03-08', '2ne578', 1, 1908593332, 697257217, -451030047, -2052653308, 543.387709);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483620, '2024-04-30', 'kv42q7', 1, -2060082151, -1122409769, 1849819405, -929383517, 13.328055);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483619, '2023-10-12', 'krpd', 1, -609553675, 989018473, -55494714, -1674145149, 554.705331);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483618, '2022-07-11', '05a9n0jxf', 1, -1165594842, -634585028, 1719800120, -210159774, 562.960947);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483617, '2020-03-13', '0', 1, 375841374, -1449226553, -225238282, -1898678660, 38.169466);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483616, '2022-01-03', '5amsorlwyngc', 1, -323362455, 453340472, 211603887, -413043724, 677.305163);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483615, '2024-10-21', 'yoeyo6l0hdt6', 1, 1435223075, 1617348603, -477129795, -1418927432, 904.57762);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483614, '2025-07-12', '1gwnlas6', 1, -2076274980, 1731324803, -1159083009, -1589605308, 437.428969);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483613, '2025-07-12', 'xih6', 1, -251205568, 287256667, 1614799674, 1083479253, 913.199755);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483612, '2022-08-11', 'aawg96aqb0tb', 1, -1216952047, -457901285, -2140923099, -841516418, 535.501742);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483611, '2025-06-14', 'cgumbc', 1, 1295379066, 1071401016, 40558455, 740386991, 843.866361);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483610, '2024-05-24', 'xw1rxe9yfk7', 1, -1046720861, 643589729, -1231488097, 956819642, 680.425625);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483609, '2024-04-04', 'dohvu06d', 1, -438741674, -154207334, 729449685, -1580984044, 422.698571);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483608, '2025-12-31', 'i2hy0', 1, 168442149, 1299171592, 2066302536, 24053253, 349.371383);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483607, '2022-11-11', 'xnjaby', 1, 462225708, 1528227252, -1277305894, -1659775598, 453.840746);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483606, '2022-09-22', '6sto1cj8sh5k', 1, 1106724223, 1966809332, 1487347213, 1328948152, 52.250567);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483605, '2021-08-21', 'gjac', 1, 973811121, 280292620, 620355627, -531872415, 5.194667);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483604, '2025-11-15', 'v4ygmayq3qdp', 1, -2082238979, -845136979, -1042976410, -1670945624, 487.287849);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483603, '2023-11-30', 'ic7', 1, 899787662, 594760660, 833568923, -384749431, 55.861048);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_87324b', 162.04354);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_a78428', 174.140432);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'A', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'T', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'a', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '"', -1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Price / T2.Amount), T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.CustomerID = (SELECT CustomerID FROM yearmonth ORDER BY Consumption DESC, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1) GROUP BY T2.CustomerID, T1.Currency;

/*
Gold Result:
(1, 1.0877501691707686e-05, 't1__d9c6c9')
*/

-- Prediction Query
SELECT T1."CustomerID", SUM(T2."Price") / SUM(T2."Amount") AS "AveragePricePerItem", T1."Currency" FROM "customers" AS T1 INNER JOIN "transactions_1k" AS T2 ON T1."CustomerID" = T2."CustomerID" GROUP BY T1."CustomerID" ORDER BY SUM(T2."Price") DESC, T1."CustomerID" NULLS LAST, AveragePricePerItem NULLS LAST, T1."Currency" NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, -1.0686805393922627e-06, 't1__d9c6c9')
*/