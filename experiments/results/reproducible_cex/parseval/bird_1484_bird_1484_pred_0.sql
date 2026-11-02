-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'Czech Republic', 'discount');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -59984348, 'wqcgsk', '9n8c4pgu7v');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -1865039888, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, -1377057208, 'ilbnp', 'mdpos');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, -1576219117, '5u', 'w6kl');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 1620389964, '00t5c4ecigc', 'e376nium52');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, -443340271, 'uo4nrqrofqy', '5s5b');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 2107872094, '02eutliqa11r', 'ytoo3o9');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, -1666765085, '72klex14ji7z', 'au2dwy');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, -953437896, '3pyu78d', '9rljsl0b4');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 1649269347, 'p5qi2rkf9v', 'x58pz');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, -1529584866, 'd2', 'vy9uxj4');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, -1612443122, 'd', 'lph2gn');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 1968874827, 'nqcx5h', 'cprj');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, -841004020, 'dz79fjg', '8n2f3');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (16, 806170397, 'qv0gcb98ozk', 'zbilyrkn');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (17, -688098735, '6ah', 'f8jswwl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(Country = 'CZE', 1, 0)) - SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations WHERE Segment = 'Discount';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (SELECT COUNT(GasStationID) FROM gasstations WHERE Country = 'Czech Republic' AND Segment = 'discount') - (SELECT COUNT(GasStationID) FROM gasstations WHERE Country = 'Slovakia' AND Segment = 'discount') AS Difference;

/*
Prediction Result:
(1,)
*/