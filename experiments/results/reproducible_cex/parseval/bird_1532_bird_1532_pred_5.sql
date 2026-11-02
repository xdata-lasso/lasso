-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 't2__0e119d', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 1465859724, 't2__0e119d', 'rwbbp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -1257178728, 't2__0e119d', 'mdpos');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 1610062532, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1610062532, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 2087640001, 'dposiie5unw', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, -1585009206, '52zb', 'uo4nrqrofqy');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 2074205376, 'yytoo', 'o9hl72kl');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 1, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2022-04-27', '8c4pgu7vfe', -1633151678, -252690330, 1, 2, 1115440883, 882.963176);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2025-08-22', 'uhv', 1526238907, -1377057208, 3, 2, -841692980, 182.319045);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2021-06-28', 'e5u', 1861536320, 44952191, 3, 2, 1151980946, -1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2020-12-06', 'a9000t5c4eci', 1149850321, -1833165707, 3, 2, 1155439218, -1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2021-06-20', 'm52zbu', -1179823637, 1119186446, 3, 2, 781505063, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2023-01-30', 'fqyp', -921187550, -2070843029, 3, 2, 328305758, -1.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2023-08-24', 'liqa1', 2074205376, 274769912, 1, 2, -188151580, 552.838162);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2025-06-17', '5sw', 1258409369, -1981402255, 3, 1, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2023-01-03', 'wbbp6luhvdlt', -841692980, -1364429300, 4, NULL, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2025-06-17', '5sw', 1258409369, -1981402255, 5, 2, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2023-01-03', 'wbbp6luhvdlt', -841692980, -1364429300, 7, 2, -1257178728, 787.938887);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2025-07-01', '4', 374105386, 1274489983, 9, 2, -1683203397, 623.093099);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2022-09-19', 's5bbp02e', -751275471, -1347802441, 11, 2, 1673584235, 6.833035);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__0e119d',)
*/

-- Prediction Query
SELECT g.Country FROM transactions_1k AS t INNER JOIN gasstations AS g ON t.GasStationID = g.GasStationID WHERE t.ProductID = 2 AND t.Amount = 1 ORDER BY t.Price DESC, t.transactionid NULLS LAST, g.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/