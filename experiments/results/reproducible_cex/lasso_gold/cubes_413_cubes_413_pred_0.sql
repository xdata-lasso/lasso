-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1014, 'science', 'decide', 'USA');
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1015, 'option', 'rate', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "airline", "abbreviation" FROM "airlines" WHERE ("country" = 'USA') ORDER BY airline, airlines.uid NULLS LAST;

/*
Gold Result:
('option', 'rate')
('science', 'decide')
*/

-- Prediction Query
SELECT Airline, Abbreviation FROM AIRLINES WHERE Country = 'USA';

/*
Prediction Result:
('science', 'decide')
('option', 'rate')
*/