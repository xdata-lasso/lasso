-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT vs ALL (duplicate countries for the target airline) and ORDER BY country (ASC vs DESC) and NULLS FIRST/LAST.
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (10, 'JetBlue Airways', 'JB1', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (20, 'JetBlue Airways', 'JB2', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (30, 'JetBlue Airways', 'JB3', 'Canada');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (40, 'JetBlue Airways', 'JB4', NULL);
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (5, 'United Airlines', 'UAL', 'Brazil');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "airlines" WHERE ("airline" = 'JetBlue Airways') ORDER BY country, airlines.uid NULLS LAST;

/*
Gold Result:
(None,)
('Canada',)
('USA',)
('USA',)
*/

-- Prediction Query
SELECT Country FROM AIRLINES WHERE Airline = 'JetBlue Airways';

/*
Prediction Result:
('USA',)
('USA',)
('Canada',)
(None,)
*/