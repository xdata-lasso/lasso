-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'sr', 'wbbp6luhvdlt');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '2dwyrq', '3pyu78d');

-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 't2__e5c497', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -1364429300, 't2__e5c497', 'nprmdposii');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, -1823627488, 't2__e5c497', 'nw6klf');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 902551284, 't2__e5c497', 'p');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-27', '8c4pgu7vfe', 1, -1633151678, 1, -252690330, 1115440883, 882.963176);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2020-01-23', '9000t5c4ec', 1, -1683203397, 2, 528680845, -1585009206, 191.847248);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2025-06-20', 'zbuo4nrq', 1, 418417917, 1, -1031969798, -1106983592, 938.694822);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2024-08-27', '2eutliqa11r', 1, 2137741668, 2, -525979501, 1898504886, 937.856955);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2022-08-06', 'o9hl72kl', 3, -305670381, 1, -1525670226, -453362185, 612.02959);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2023-01-20', 'jsl', 1, -346339240, 2, 1692174491, -1025564911, 447.109657);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2021-11-05', '9v', 3, 556727997, 1, 1178000634, 1836127587, 410.133844);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2020-12-28', '8jegd21vy9ux', 1, -1492524358, 2, -1612443122, -2050247126, 328.40866);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2022-09-24', 'h2gndqwnqcx5', 3, 580968159, 1, -1245312912, 1575412235, 269.734861);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2023-05-30', '0dz79f', 1, -1485777725, 1, -1255130038, -1762857309, 687.701166);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2022-11-06', '0gcb98', 1, -1454058168, 1, -2078052421, -512640349, 741.809988);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2022-04-12', '6vck6ah0f8js', 1, -658391922, 1, -1388029300, -566887085, 598.428216);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201306', 304.02808);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '201306', 550.03107);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't3__d620c6', 949.322482);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 640.201736);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('t2__e5c497',)
('t2__e5c497',)
('t2__e5c497',)
('t2__e5c497',)
('t2__e5c497',)
('t2__e5c497',)
('t2__e5c497',)
('t2__e5c497',)
('t2__e5c497',)
*/

-- Prediction Query
SELECT DISTINCT gasstations.Country FROM gasstations INNER JOIN transactions_1k ON gasstations.GasStationID = transactions_1k.GasStationID INNER JOIN yearmonth ON transactions_1k.CustomerID = yearmonth.CustomerID WHERE yearmonth.Date = '201306';

/*
Prediction Result:
('t2__e5c497',)
*/