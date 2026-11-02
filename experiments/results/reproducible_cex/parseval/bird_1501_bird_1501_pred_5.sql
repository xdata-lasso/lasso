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

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, '72k', 'ex1');

-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 't2__0be8a6', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, -1364429300, 't2__0be8a6', 'nprmdposii');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -1179823637, 't2__0be8a6', 'rqro');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2022-04-27', '8c4pgu7vfe', 1, -1633151678, 1, -252690330, 1115440883, 882.963176);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2020-11-04', 'unw6klfa', 1, 1419861592, 1, 700088193, 374105386, 950.466571);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2020-06-23', 'gce', 1, -1585009206, 3, -53231346, -443340271, 676.357279);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2020-12-02', 'qyp5s5bbp0', 1, 743312762, 3, -1822992503, -868774469, 138.017996);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2022-10-26', '1', 3, 2074205376, 1, 274769912, -188151580, 552.838162);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2021-06-29', '7zwau2dwyr', 1, -1021749117, 3, 392822403, 2142703426, 375.832821);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2025-11-02', 'd99rljsl0', 3, -2031361952, 1, 1649269347, -1116181514, 792.401003);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2021-07-18', 'rkf9vqx5', 1, 1836127587, 3, -1529584866, 1196308825, 712.084197);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2025-01-26', 'vy9uxj4', 3, -1612443122, 1, -2050247126, -736979194, 989.653112);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2021-04-26', 'gndqwnqc', 1, 555413010, 1, 722884590, 580968159, 210.05299);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2022-09-19', 'jtu0d', 1, 401805964, 1, -1485777725, -1255130038, 89.552801);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2020-08-04', 'qv0gcb98ozk', 1, -155284187, 1, 1686459626, -1554531873, 728.712934);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201306', 304.02808);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (2, '201306', 482.572691);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't3__1b8361', 279.382219);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 170.168747);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('t2__0be8a6',)
('t2__0be8a6',)
('t2__0be8a6',)
('t2__0be8a6',)
('t2__0be8a6',)
*/

-- Prediction Query
SELECT DISTINCT gasstations.country FROM transactions_1k INNER JOIN yearmonth ON transactions_1k.customerid = yearmonth.customerid INNER JOIN gasstations ON transactions_1k.gasstationid = gasstations.gasstationid WHERE SUBSTRING(yearmonth.date, 1, 6) = '201306';

/*
Prediction Result:
('t2__0be8a6',)
*/