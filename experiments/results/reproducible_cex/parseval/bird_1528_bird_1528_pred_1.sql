-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483648, -55602865, 'SVK', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 1610062532, 'SVK', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483646, -106629402, 'gas_070f13', 'u7');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483645, -734455130, 'SVK', '4h');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483644, -992890117, 'SVK', 'gas_39ce5a');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1914020640, 'SVK', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1268590800, 'SVK', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1219478689, 'SVK', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, -1670923962, 'SVK', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 700293388, 'SVK', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 906324270, 'SVK', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 1908028688, 'SVK', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 2122220075, 'SVK', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 1072996612, 'SVK', 'Premium');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Country = 'SVK' AND Segment = 'Premium', 1, 0)) AS REAL) * 100 / SUM(IIF(Country = 'SVK', 1, 0)) FROM gasstations;

/*
Gold Result:
(76.92307692307692,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN Segment = 'Premium' THEN 1 ELSE 0 END) AS REAL) / COUNT(*)) * 100 AS premium_percentage FROM gasstations WHERE Country = 'SVK';

/*
Prediction Result:
(76.92307692307693,)
*/