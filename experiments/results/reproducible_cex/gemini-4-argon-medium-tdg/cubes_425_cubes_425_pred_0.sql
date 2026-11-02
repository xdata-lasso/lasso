-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (10, 'JetBlue Airways', 'JBU1', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (20, 'JetBlue Airways', 'JBU2', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (30, 'JetBlue Airways', 'JBU3', 'Canada');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (40, 'JetBlue Airways', 'JBU4', NULL);
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