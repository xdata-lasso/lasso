-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("productid", "description") VALUES (1, 't2__c164de');

INSERT INTO "products" ("productid", "description") VALUES (2, 't2__c164de');

INSERT INTO "products" ("productid", "description") VALUES (-2147483647, 't2__c164de');

INSERT INTO "products" ("productid", "description") VALUES (3, 'u7');

INSERT INTO "products" ("productid", "description") VALUES (4, NULL);

INSERT INTO "products" ("productid", "description") VALUES (5, 'uzhs');

INSERT INTO "products" ("productid", "description") VALUES (6, NULL);

INSERT INTO "products" ("productid", "description") VALUES (7, 'dposiie5unw');

INSERT INTO "products" ("productid", "description") VALUES (8, NULL);

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2025-06-17', '5sw', 1258409369, -1981402255, -890215420, 1, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2021-02-11', 'u7vfe4hria2y', 1115440883, 1644814318, 1465859724, 3, -1349201381, 737.440743);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2023-10-03', 'l', -845863578, -1610064545, 429706943, 1, 0, 240.969194);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2023-01-01', 'dpos', -1576219117, -1823627488, -1209887326, 1, -1, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2021-10-25', 'fa9', 1620389964, 546571701, 947159877, 1, 0, 963.351729);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2025-07-01', '4', 374105386, 1274489983, -1683203397, 1, -1, 623.093099);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2025-03-28', '6nium52zb', 757448742, -1179823637, 1119186446, 1, 781505063, 597.420508);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2022-06-23', 'fqyp5s5bbp0', 743312762, -1822992503, -868774469, 1, -1068298341, 427.383654);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-10-14', 'yytoo', 1644911394, -1666765085, 1178636309, 1, -1390245819, 763.856372);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2024-03-14', '4ji7zwa', 2123196517, 364869063, -953437896, 1, -1097120355, 326.912005);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2020-07-21', '9rljsl0b4', 1649269347, -1116181514, 1255852738, 1, 0, 137.842122);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2023-01-22', 'f9v', 556727997, 1178000634, 1836127587, 1, -1, 410.133844);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2020-12-28', '8jegd21vy9ux', -1492524358, -1612443122, -2050247126, 1, 0, 328.40866);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-06-17', '5sw', 1258409369, -1981402255, -890215420, 3, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2023-09-09', 'e4', 1160656988, -992890117, 1914020640, 5, 1268590800, 378.476082);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2023-01-03', 'wbbp6luhvdlt', -841692980, -1364429300, -1257178728, 7, 1236688122, 986.066566);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('t2__c164de',)
('u7',)
('uzhs',)
('dposiie5unw',)
('t2__c164de',)
*/

-- Prediction Query
SELECT p.description FROM products AS p INNER JOIN (SELECT productid, SUM(amount) AS totalsales FROM transactions_1k GROUP BY productid ORDER BY totalsales DESC, productid NULLS LAST LIMIT 5) AS t ON p.productid = t.productid;

/*
Prediction Result:
('uzhs',)
('dposiie5unw',)
('u7',)
('t2__c164de',)
*/