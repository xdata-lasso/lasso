-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1027, 1031, 'Saint Vincent and the Grenadines', 'Value for money');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1028, 1036.0, 'Saint Vincent and the Grenadines', 'Value for money');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1029, 1041.0, 'Saint Vincent and the Grenadines', 'Value for money');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1030, 1046.0, 'Saint Vincent and the Grenadines', 'Value for money');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1035, NULL, 'Falkland Islands (Malvinas)', 'Value for money');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1036, NULL, 'Falkland Islands (Malvinas)', 'Value for money');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1037, NULL, 'Falkland Islands (Malvinas)', 'Value for money');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1038, NULL, 'Falkland Islands (Malvinas)', 'Value for money');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Country, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country ORDER BY COUNT(GasStationID) DESC, Country NULLS LAST, (SELECT COUNT(GasStationID) FROM gasstations WHERE Segment = 'Value for money') NULLS LAST LIMIT 1;

/*
Gold Result:
('Falkland Islands (Malvinas)', 8)
*/

-- Prediction Query
SELECT Country, COUNT(*) AS Total_Value_for_Money_GasStations FROM gasstations WHERE Segment = 'Value for money' GROUP BY Country;

/*
Prediction Result:
('Falkland Islands (Malvinas)', 4)
('Saint Vincent and the Grenadines', 4)
*/