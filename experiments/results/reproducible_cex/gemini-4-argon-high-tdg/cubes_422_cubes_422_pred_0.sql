-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (1, 'Zeta Airlines', 'UAL', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (2, 'United Airlines', 'UAL', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (3, 'Alpha Air', 'UAL', 'Canada');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (4, 'Lower Air', 'ual', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (5, 'Prefix Air', 'UAL1', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (6, 'Before UAL', 'UAK', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (7, 'After UAL', 'UAM', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (8, 'Null Abbrev Air', NULL, 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "airline" FROM "airlines" WHERE ("abbreviation" = 'UAL') ORDER BY airline, airlines.uid NULLS LAST;

/*
Gold Result:
('Alpha Air',)
('United Airlines',)
('Zeta Airlines',)
*/

-- Prediction Query
SELECT Airline FROM AIRLINES WHERE Abbreviation = 'UAL';

/*
Prediction Result:
('Zeta Airlines',)
('United Airlines',)
('Alpha Air',)
*/