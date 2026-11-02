-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('C01', 'City1', 'Zeta Airport', 'Country1', 'C1');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('B02', 'City2', NULL, 'Country2', 'C2');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('A03', 'City3', 'Alpha Airport', 'Country3', 'C3');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES (NULL, 'City4', 'Alpha Airport', 'Country4', 'C4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airportname FROM airports ORDER BY airportname, airports.airportcode NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Airport',)
('Alpha Airport',)
('Zeta Airport',)
*/

-- Prediction Query
SELECT AirportName FROM Airports WHERE NOT AirportCode IN (SELECT SourceAirport FROM Flights UNION SELECT DestAirport FROM Flights);

/*
Prediction Result:
('Zeta Airport',)
(None,)
('Alpha Airport',)
('Alpha Airport',)
*/