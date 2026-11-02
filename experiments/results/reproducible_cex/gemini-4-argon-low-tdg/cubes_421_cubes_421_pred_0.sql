-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "airports" ("AirportCode", "City", "AirportName", "Country", "CountryAbbrev") VALUES ('JFK', 'New York', 'John F Kennedy', 'USA', 'US');
INSERT INTO "airports" ("AirportCode", "City", "AirportName", "Country", "CountryAbbrev") VALUES ('LAX', 'Los Angeles', 'Los Angeles Intl', 'USA', 'US');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (10, 'United Airlines', 'UAL', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (20, 'United Airlines', 'UAX', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (30, 'American Airlines', 'United Airlines', 'USA');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (10, 500, 'LAX', 'JFK');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (20, 500, 'JFK', 'LAX');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (20, 10, 'LAX', 'JFK');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (30, 25, 'JFK', 'LAX');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "flightno" FROM (SELECT "LHS"."uid" AS "uid", "LHS"."airline" AS "airline", "LHS"."abbreviation" AS "abbreviation", "LHS"."country" AS "country", "RHS"."flightno" AS "flightno", "RHS"."sourceairport" AS "sourceairport", "RHS"."destairport" AS "destairport" FROM (SELECT * FROM "airlines" WHERE ("airline" = 'United Airlines')) AS LHS INNER JOIN flights AS RHS ON (LHS.uid = RHS.airline)) ORDER BY flightno, "flightno" NULLS LAST;

/*
Gold Result:
(10,)
(500,)
(500,)
*/

-- Prediction Query
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRLINES AS T2 ON T2.uid = T1.Airline WHERE T2.Airline = 'United Airlines';

/*
Prediction Result:
(500,)
(10,)
(500,)
*/