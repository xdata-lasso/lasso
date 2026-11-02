-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'CZE', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -55602865, 'CZE', 'gas_610ded');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, 1, 'CZE', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, -59984348, 'gas_b69c07', 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, -664303813, 'gas_b69c07', 'gas_610ded');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 1, 'gas_b69c07', NULL);

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 1, NULL, 'Premium');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 1, NULL, 'gas_610ded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(GasStationID) FROM gasstations WHERE Country = 'CZE' AND Segment = 'Premium';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT g.GasStationID) FROM gasstations AS g JOIN transactions_1k AS t ON g.GasStationID = t.GasStationID JOIN products AS p ON t.ProductID = p.ProductID WHERE g.Country = 'CZE' AND (p.Description = 'Premium' OR g.Segment = 'Premium');

/*
Prediction Result:
(0,)
*/