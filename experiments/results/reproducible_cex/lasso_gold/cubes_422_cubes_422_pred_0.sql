-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1014, 'science', 'UAL', 'Congo');
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1015, 'option', 'UAL', 'Pakistan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "airline" FROM "airlines" WHERE ("abbreviation" = 'UAL') ORDER BY airline, airlines.uid NULLS LAST;

/*
Gold Result:
('option',)
('science',)
*/

-- Prediction Query
SELECT Airline FROM AIRLINES WHERE Abbreviation = 'UAL';

/*
Prediction Result:
('science',)
('option',)
*/