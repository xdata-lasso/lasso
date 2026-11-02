-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'SVK', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 1, 'SVK', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 1, 'SVK', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Segment = 'Premium', 1, 0)) AS REAL) * 100 / COUNT(GasStationID) FROM gasstations WHERE Country = 'SVK';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN Segment = 'Premium' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM gasstations WHERE Country = 'Slovakia';

/*
Prediction Result:
(None,)
*/