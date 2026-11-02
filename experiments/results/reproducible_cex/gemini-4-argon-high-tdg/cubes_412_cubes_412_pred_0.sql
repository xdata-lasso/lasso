-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (1, 'Global Air', 'GLA', 'United States');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (2, 'Northern Wings', 'NWG', 'Canada');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('M02', 'Zeta City', 'Charlie Field', 'United States', 'US');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('Z03', 'Beta Town', 'Alpha International', 'Canada', 'CA');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('A01', 'Alpha Ville', 'Bravo Regional', 'Mexico', 'MX');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('K04', 'Delta Port', 'Delta Municipal', 'Brazil', 'BR');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (1, 101, 'M02', 'Z03');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (1, 102, 'A01', 'Z03');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (2, 201, 'Z03', 'M02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airportname FROM airports ORDER BY airportname, airports.airportcode NULLS LAST;

/*
Gold Result:
('Alpha International',)
('Bravo Regional',)
('Charlie Field',)
('Delta Municipal',)
*/

-- Prediction Query
SELECT AirportName FROM Airports WHERE NOT AirportCode IN (SELECT SourceAirport FROM Flights UNION SELECT DestAirport FROM Flights);

/*
Prediction Result:
('Delta Municipal',)
*/