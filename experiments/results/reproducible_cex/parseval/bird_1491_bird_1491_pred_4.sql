-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'gas_d23a34', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (0, -59984348, '!', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, -664303813, '!', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483645, -1022641847, 'B', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483644, -1726781632, '!', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483643, 247012447, 'Q', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483642, -1980249628, 'I', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483641, -734455130, 'G', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483640, 1744686505, 'O', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -55602865, 'gas_192c75', 'Value for money');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -59984348, 'gas_192c75', 'Value for money');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Country, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country ORDER BY COUNT(GasStationID) DESC, Country NULLS LAST, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') NULLS LAST LIMIT 1;

/*
Gold Result:
('!', 11)
*/

-- Prediction Query
SELECT Country, COUNT(CASE WHEN Segment = 'Value for money' THEN GasStationID END) FROM gasstations GROUP BY Country;

/*
Prediction Result:
('!', 3)
('B', 1)
('G', 1)
('I', 1)
('O', 1)
('Q', 1)
('gas_192c75', 2)
('gas_d23a34', 1)
*/