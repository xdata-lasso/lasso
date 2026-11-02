-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (1, 'United Airlines', 'UAL', 'USA');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('JFK', 'New York', 'John F Kennedy International', 'United States', 'US');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('LAX', 'Los Angeles', 'Los Angeles International', 'United States', 'US');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM flights ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM FLIGHTS;

/*
Prediction Result:
(0,)
*/