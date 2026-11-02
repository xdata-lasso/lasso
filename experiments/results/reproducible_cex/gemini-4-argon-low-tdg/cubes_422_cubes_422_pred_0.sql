-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT vs ALL, ORDER BY direction, and NULLS LAST behavior.
-- Includes multiple 'UAL' entries with duplicate Airline names, different Airline names, and a NULL Airline name.
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (10, 'Zeta Airlines', 'UAL', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (20, 'Alpha Airlines', 'UAL', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (30, 'Alpha Airlines', 'UAL', 'Canada');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (5, NULL, 'UAL', 'UK');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (15, 'Beta Airlines', 'DAL', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "airline" FROM "airlines" WHERE ("abbreviation" = 'UAL') ORDER BY airline, airlines.uid NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Airlines',)
('Alpha Airlines',)
('Zeta Airlines',)
*/

-- Prediction Query
SELECT Airline FROM AIRLINES WHERE Abbreviation = 'UAL';

/*
Prediction Result:
(None,)
('Zeta Airlines',)
('Alpha Airlines',)
('Alpha Airlines',)
*/