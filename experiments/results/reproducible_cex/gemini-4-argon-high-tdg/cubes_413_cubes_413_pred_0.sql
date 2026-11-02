-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (1, 'United Airlines', 'UAL', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (2, 'American Airlines', 'AAL', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (3, 'British Airways', 'BAW', 'UK');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (4, 'Delta Air Lines', 'DAL', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (5, 'Air Canada', 'ACA', 'Canada');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('JFK', 'New York', 'John F Kennedy', 'USA', 'US');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('LAX', 'Los Angeles', 'Los Angeles Intl', 'USA', 'US');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('LHR', 'London', 'Heathrow', 'UK', 'GB');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (1, 100, 'LAX', 'JFK');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (1, 101, 'JFK', 'LAX');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (3, 200, 'JFK', 'LHR');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "airline", "abbreviation" FROM "airlines" WHERE ("country" = 'USA') ORDER BY airline, airlines.uid NULLS LAST;

/*
Gold Result:
('American Airlines', 'AAL')
('Delta Air Lines', 'DAL')
('United Airlines', 'UAL')
*/

-- Prediction Query
SELECT Airline, Abbreviation FROM AIRLINES WHERE Country = 'USA';

/*
Prediction Result:
('United Airlines', 'UAL')
('American Airlines', 'AAL')
('Delta Air Lines', 'DAL')
*/