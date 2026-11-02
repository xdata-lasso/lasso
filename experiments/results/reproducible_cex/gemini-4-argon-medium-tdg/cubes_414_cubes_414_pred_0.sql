-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (1, 'JetBlue Airways', 'JetBlue', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (2, 'United Airlines', 'United', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (3, 'JetBlue Airways', 'JBU', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (4, 'JetBlue Airways', 'JetBlue', 'Canada');
INSERT INTO "airports" ("AirportCode", "City", "AirportName", "Country", "CountryAbbrev") VALUES ('JFK', 'New York', 'John F. Kennedy', 'USA', 'US');
INSERT INTO "airports" ("AirportCode", "City", "AirportName", "Country", "CountryAbbrev") VALUES ('BOS', 'Boston', 'Logan International', 'USA', 'US');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (1, 100, 'JFK', 'BOS');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (1, 101, 'BOS', 'JFK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "abbreviation" FROM "airlines" WHERE ("airline" = 'JetBlue Airways') ORDER BY abbreviation, airlines.uid NULLS LAST;

/*
Gold Result:
('JBU',)
('JetBlue',)
('JetBlue',)
*/

-- Prediction Query
SELECT Abbreviation FROM AIRLINES WHERE Airline = 'JetBlue Airways';

/*
Prediction Result:
('JetBlue',)
('JBU',)
('JetBlue',)
*/