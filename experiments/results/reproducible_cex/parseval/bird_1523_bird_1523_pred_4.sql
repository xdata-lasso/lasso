-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 't2__262c19', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1465859724, 't2__262c19', 'rwbbp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 13244799, 't2__262c19', 'hvdltt');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 1419861592, 't2__262c19', '4ecigce376n');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1610062532, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1610062532, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, -1585009206, '52zb', 'uo4nrqrofqy');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 2074205376, 'yytoo', 'o9hl72kl');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 1, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-27', '8c4pgu7vfe', -1633151678, 667467, 1, -252690330, 1115440883, 882.963176);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2021-05-27', 'bnp', 1236688122, 667467, 2, 2087640001, 907682809, 227.766936);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2023-03-17', 'ie5', -1209887326, 667467, 3, -1399556171, 1038707349, 587.783596);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2021-06-20', 'm52zbu', -1179823637, 667467, 2, 1119186446, 781505063, 597.420508);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2022-06-23', 'fqyp5s5bbp0', 743312762, 667467, 2, -1822992503, -868774469, 138.017996);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2022-10-26', '1', 2074205376, 667467, 2, 274769912, -188151580, 552.838162);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2022-02-06', '72klex14ji7z', -2081315180, 667467, 1, 1909986641, 1485335077, 721.918386);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2024-04-09', 'q13py', 244829661, 667467, 1, -1362461264, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2025-04-09', 'p5qi2rk', -705985602, 1, 1, 537874887, -461695645, 694.765963);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-06-17', '5sw', 1258409369, NULL, 4, -1981402255, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2025-06-17', '5sw', 1258409369, 667467, 5, -1981402255, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2023-01-03', 'wbbp6luhvdlt', -841692980, 667467, 7, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2025-07-01', '4', 374105386, 667467, 9, 1274489983, -1683203397, 623.093099);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2022-09-19', 's5bbp02e', -751275471, 667467, 11, -1347802441, 1673584235, 6.833035);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
('t2__262c19',)
('t2__262c19',)
('t2__262c19',)
('t2__262c19',)
('t2__262c19',)
('t2__262c19',)
('t2__262c19',)
('t2__262c19',)
('pgu7vfe4',)
('dposiie5unw',)
('52zb',)
('yytoo',)
*/

-- Prediction Query
SELECT DISTINCT gasstations.Country FROM gasstations INNER JOIN transactions_1k ON gasstations.GasStationID = transactions_1k.GasStationID WHERE transactions_1k.CardID = 667467;

/*
Prediction Result:
('t2__262c19',)
('pgu7vfe4',)
('dposiie5unw',)
('52zb',)
('yytoo',)
*/