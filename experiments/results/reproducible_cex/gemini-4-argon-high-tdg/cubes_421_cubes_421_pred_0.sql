-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('SFO', 'San Francisco', 'San Francisco International', 'United States', 'US');
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('DEN', 'Denver', 'Denver International', 'United States', 'US');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (10, 'United Airlines', 'UA', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (20, 'United Airlines', 'UAL', 'UK');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (10, 400, 'SFO', 'DEN');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (20, 400, 'DEN', 'SFO');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (20, 50, 'SFO', 'DEN');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (10, 300, 'DEN', 'SFO');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "flightno" FROM (SELECT "LHS"."uid" AS "uid", "LHS"."airline" AS "airline", "LHS"."abbreviation" AS "abbreviation", "LHS"."country" AS "country", "RHS"."flightno" AS "flightno", "RHS"."sourceairport" AS "sourceairport", "RHS"."destairport" AS "destairport" FROM (SELECT * FROM "airlines" WHERE ("airline" = 'United Airlines')) AS LHS INNER JOIN flights AS RHS ON (LHS.uid = RHS.airline)) ORDER BY flightno, "flightno" NULLS LAST;

/*
Gold Result:
(50,)
(300,)
(400,)
(400,)
*/

-- Prediction Query
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRLINES AS T2 ON T2.uid = T1.Airline WHERE T2.Airline = 'United Airlines';

/*
Prediction Result:
(300,)
(400,)
(50,)
(400,)
*/