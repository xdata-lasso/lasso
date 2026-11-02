-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'gas_deb28f', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -59984348, 'gas_deb28f', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (0, -664303813, '1', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483646, -1022641847, '1', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-1, -1726781632, '"', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483643, 247012447, 'D', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483642, -1980249628, 'g', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483641, -734455130, 'G', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483640, 1744686505, 'G', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483639, -1633151678, '#', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -55602865, 'gas_19e2e8', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, -59984348, 'gas_19e2e8', 'Value for money');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Country, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country ORDER BY COUNT(GasStationID) DESC, Country NULLS LAST, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') NULLS LAST LIMIT 1;

/*
Gold Result:
('1', 12)
*/

-- Prediction Query
SELECT Country, COUNT(*) AS "Value for Money Gas Stations" FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country;

/*
Prediction Result:
('"', 1)
('#', 1)
('1', 2)
('D', 1)
('G', 2)
('g', 1)
('gas_19e2e8', 2)
('gas_deb28f', 2)
*/