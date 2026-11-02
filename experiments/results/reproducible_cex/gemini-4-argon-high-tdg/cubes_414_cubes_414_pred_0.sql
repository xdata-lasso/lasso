-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (1, 'JetBlue Airways', 'Z_JBU', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (2, 'JetBlue Airways', 'M_JBU', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (3, 'JetBlue Airways', 'A_JBU', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "abbreviation" FROM "airlines" WHERE ("airline" = 'JetBlue Airways') ORDER BY abbreviation, airlines.uid NULLS LAST;

/*
Gold Result:
('A_JBU',)
('M_JBU',)
('Z_JBU',)
*/

-- Prediction Query
SELECT Abbreviation FROM AIRLINES WHERE Airline = 'JetBlue Airways';

/*
Prediction Result:
('Z_JBU',)
('M_JBU',)
('A_JBU',)
*/