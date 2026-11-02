-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('USA' vs other values, case sensitivity, trailing spaces, substrings, NULLs) and basic ordering.
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (1, 'Delta Air Lines', 'DL', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (2, 'American Airlines', 'AA', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (3, 'Air Canada', 'AC', 'Canada');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (4, 'United Airlines', 'UA', 'usa');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (5, 'Southwest Airlines', 'WN', 'USA ');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (6, 'JetBlue', 'B6', 'US');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (7, 'Ghost Air', 'GA', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "airline", "abbreviation" FROM "airlines" WHERE ("country" = 'USA') ORDER BY airline, airlines.uid NULLS LAST;

/*
Gold Result:
('American Airlines', 'AA')
('Delta Air Lines', 'DL')
*/

-- Prediction Query
SELECT Airline, Abbreviation FROM AIRLINES WHERE Country = 'USA';

/*
Prediction Result:
('Delta Air Lines', 'DL')
('American Airlines', 'AA')
*/