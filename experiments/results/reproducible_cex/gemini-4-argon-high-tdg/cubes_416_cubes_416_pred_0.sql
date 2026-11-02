-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('JFK', 'New York', 'John F Kennedy Intl', 'USA', 'US');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('LAX', 'Los Angeles', 'Los Angeles Intl', 'USA', 'US');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (1, 'Delta', 'DL', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (2, 'United', 'UA', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (10, 'Southwest', 'WN', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (20, 'Southwest', 'WN', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (30, 'JetBlue', 'B6', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (31, 'JetBlue', 'B6', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (32, 'JetBlue', 'B6', 'USA');
INSERT INTO flights (Airline, FlightNo, SourceAirport, DestAirport) VALUES (3, 100, 'JFK', 'LAX');
INSERT INTO flights (Airline, FlightNo, SourceAirport, DestAirport) VALUES (2, 20, 'LAX', 'JFK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airline_other AS airline FROM (SELECT * FROM (SELECT * FROM (SELECT airline, flightno, sourceairport, destairport, airline_other, airline AS n FROM (SELECT LHS.airline AS airline, LHS.flightno AS flightno, LHS.sourceairport AS sourceairport, LHS.destairport AS destairport, RHS.airline AS airline_other FROM flights AS LHS INNER JOIN (SELECT airline, COUNT(*) AS n FROM airlines GROUP BY airline) AS RHS ON (LHS.airline = RHS.n))) ORDER BY flightno) LIMIT 1);

/*
Gold Result:
('Southwest',)
*/

-- Prediction Query
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid = T2.Airline GROUP BY T1.Airline ORDER BY COUNT(*) DESC, T1.Airline NULLS LAST LIMIT 1;

/*
Prediction Result:
('United',)
*/