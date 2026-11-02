-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 't2__8719bd', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 1465859724, 't2__8719bd', 'rwbbp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -1209887326, 't2__8719bd', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1610062532, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1610062532, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, -1585009206, '52zb', 'uo4nrqrofqy');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 2074205376, 'yytoo', 'o9hl72kl');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 1, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-27', '8c4pgu7vfe', -1633151678, 667467, 1, -252690330, 1115440883, 882.963176);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2025-08-22', 'uhv', 1526238907, 667467, 1, -1377057208, -841692980, 182.319045);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2022-04-29', 'rmdp', 2026480202, 667467, 1, -1576219117, -1823627488, 327.753528);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2025-07-01', '4', 374105386, 667467, 2, 1274489983, -1683203397, 623.093099);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2025-03-28', '6nium52zb', 757448742, 667467, 2, -1179823637, 1119186446, 590.639932);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2023-02-21', 'qrofqyp5s5b', 2107872094, 667467, 2, 882961052, 743312762, 825.231787);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2020-11-05', 'tliqa1', 2074205376, 667467, 1, 274769912, -188151580, 552.838162);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2022-02-06', '72klex14ji7z', -2081315180, 667467, 1, 1909986641, 1485335077, 721.918386);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2024-04-09', 'q13py', 244829661, 1, 1, -1362461264, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-06-17', '5sw', 1258409369, NULL, 2, -1981402255, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2025-06-17', '5sw', 1258409369, 667467, 4, -1981402255, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2023-01-03', 'wbbp6luhvdlt', -841692980, 667467, 6, -1364429300, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2025-07-01', '4', 374105386, 667467, 8, 1274489983, -1683203397, 623.093099);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2022-09-19', 's5bbp02e', -751275471, 667467, 10, -1347802441, 1673584235, 6.833035);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
('t2__8719bd',)
('t2__8719bd',)
('t2__8719bd',)
('pgu7vfe4',)
('pgu7vfe4',)
('pgu7vfe4',)
('t2__8719bd',)
('t2__8719bd',)
('pgu7vfe4',)
('dposiie5unw',)
('52zb',)
('yytoo',)
*/

-- Prediction Query
SELECT DISTINCT "gasstations"."country" FROM "transactions_1k" INNER JOIN "gasstations" ON "transactions_1k"."gasstationid" = "gasstations"."gasstationid" WHERE "transactions_1k"."cardid" = 667467;

/*
Prediction Result:
('t2__8719bd',)
('pgu7vfe4',)
('dposiie5unw',)
('52zb',)
('yytoo',)
*/