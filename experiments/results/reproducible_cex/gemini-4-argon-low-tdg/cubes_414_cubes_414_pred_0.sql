-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (10, 'JetBlue Airways', 'JBU', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (20, 'JetBlue Airways', 'JBU', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (5, 'JetBlue Airways', 'JB', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (1, 'JetBlue Airways', 'Z_JB', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (15, 'JetBlue Airways', NULL, 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (25, 'Delta Airlines', 'DAL', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "abbreviation" FROM "airlines" WHERE ("airline" = 'JetBlue Airways') ORDER BY abbreviation, airlines.uid NULLS LAST;

/*
Gold Result:
(None,)
('JB',)
('JBU',)
('JBU',)
('Z_JB',)
*/

-- Prediction Query
SELECT Abbreviation FROM AIRLINES WHERE Airline = 'JetBlue Airways';

/*
Prediction Result:
('Z_JB',)
('JB',)
('JBU',)
(None,)
('JBU',)
*/