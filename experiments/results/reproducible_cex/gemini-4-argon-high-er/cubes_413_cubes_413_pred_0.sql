-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (1, 'JetBlue', 'B6', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (2, 'Delta', 'DL', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "airline", "abbreviation" FROM "airlines" WHERE ("country" = 'USA') ORDER BY airline, airlines.uid NULLS LAST;

/*
Gold Result:
('Delta', 'DL')
('JetBlue', 'B6')
*/

-- Prediction Query
SELECT Airline, Abbreviation FROM AIRLINES WHERE Country = 'USA';

/*
Prediction Result:
('JetBlue', 'B6')
('Delta', 'DL')
*/