-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (1, 'JetBlue Airways', 'JBU', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (2, 'JetBlue Airways', 'JBU', 'Canada');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "airlines" WHERE ("airline" = 'JetBlue Airways') ORDER BY country, airlines.uid NULLS LAST;

/*
Gold Result:
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT Country FROM AIRLINES WHERE Airline = 'JetBlue Airways';

/*
Prediction Result:
('USA',)
('Canada',)
*/