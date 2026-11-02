-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('A1', 'City1', 'Airport1', 'Country1', 'C1');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (1, 100, 'A1', 'A1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airportname FROM airports ORDER BY airportname, airports.airportcode NULLS LAST;

/*
Gold Result:
('Airport1',)
*/

-- Prediction Query
SELECT AirportName FROM Airports WHERE NOT AirportCode IN (SELECT SourceAirport FROM Flights UNION SELECT DestAirport FROM Flights);

/*
Prediction Result:
*/