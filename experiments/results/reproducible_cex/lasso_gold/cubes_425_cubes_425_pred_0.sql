-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1014, 'JetBlue Airways', 'option', 'Reunion');
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1015, 'JetBlue Airways', 'sense', 'Congo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "airlines" WHERE ("airline" = 'JetBlue Airways') ORDER BY country, airlines.uid NULLS LAST;

/*
Gold Result:
('Congo',)
('Reunion',)
*/

-- Prediction Query
SELECT Country FROM AIRLINES WHERE Airline = 'JetBlue Airways';

/*
Prediction Result:
('Reunion',)
('Congo',)
*/