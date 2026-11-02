-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY airline ASC vs DESC, DISTINCT vs ALL (duplicate Airline names), and multiple flights per airline (join fan-out).
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (10, 'Zeta Airlines', 'UAL', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (20, 'Alpha Airlines', 'UAL', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (30, 'Alpha Airlines', 'UAL', 'Canada');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (40, 'Beta Airlines', 'DAL', 'USA');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('ORD', 'Chicago', 'OHare', 'USA', 'US');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('SFO', 'San Francisco', 'San Francisco Intl', 'USA', 'US');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (10, 1, 'ORD', 'SFO');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (10, 2, 'SFO', 'ORD');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (20, 1, 'ORD', 'SFO');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "airline" FROM "airlines" WHERE ("abbreviation" = 'UAL') ORDER BY airline, airlines.uid NULLS LAST;

/*
Gold Result:
('Alpha Airlines',)
('Alpha Airlines',)
('Zeta Airlines',)
*/

-- Prediction Query
SELECT Airline FROM AIRLINES WHERE Abbreviation = 'UAL';

/*
Prediction Result:
('Zeta Airlines',)
('Alpha Airlines',)
('Alpha Airlines',)
*/