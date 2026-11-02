-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('JFK', 'New York', 'John F Kennedy', 'United States', 'USA');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('LHR', 'London', 'Heathrow', 'United Kingdom', 'UK');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('AAA', 'Anaa', 'Central Airport', 'French Polynesia', 'PF');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('ZZZ', 'Zuni', 'Central Airport', 'United States', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airportname FROM airports ORDER BY airportname, airports.airportcode NULLS LAST;

/*
Gold Result:
('Central Airport',)
('Central Airport',)
('Heathrow',)
('John F Kennedy',)
*/

-- Prediction Query
SELECT AirportName FROM Airports WHERE NOT AirportCode IN (SELECT SourceAirport FROM Flights UNION SELECT DestAirport FROM Flights);

/*
Prediction Result:
('John F Kennedy',)
('Heathrow',)
('Central Airport',)
('Central Airport',)
*/