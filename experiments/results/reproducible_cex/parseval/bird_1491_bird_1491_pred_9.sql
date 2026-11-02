-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'gas_9c4926', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -59984348, 'gas_9c4926', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -664303813, 'gas_9c4926', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (0, -1022641847, 'gas_9c4926', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483645, -1726781632, 'gas_9c4926', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483643, 247012447, 'gas_9c4926', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483642, -1980249628, 'gas_9c4926', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483641, -734455130, 'G', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483640, 1744686505, 'G', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483639, -1633151678, 'O', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483638, -252690330, 'O', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, -55602865, 'gas_e149ed', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, -59984348, 'gas_e149ed', 'Value for money');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Country, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country ORDER BY COUNT(GasStationID) DESC, Country NULLS LAST, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') NULLS LAST LIMIT 1;

/*
Gold Result:
('gas_9c4926', 13)
*/

-- Prediction Query
SELECT Country, COUNT(*) AS num_value_for_money_stations FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country;

/*
Prediction Result:
('G', 2)
('O', 2)
('gas_9c4926', 7)
('gas_e149ed', 2)
*/