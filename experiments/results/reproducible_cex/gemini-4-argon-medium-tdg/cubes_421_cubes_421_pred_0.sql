-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "airports" ("AirportCode", "City", "AirportName", "Country", "CountryAbbrev") VALUES ('ORD', 'Chicago', 'O''Hare International', 'USA', 'US');
INSERT INTO "airports" ("AirportCode", "City", "AirportName", "Country", "CountryAbbrev") VALUES ('LAX', 'Los Angeles', 'Los Angeles International', 'USA', 'US');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (1, 'United Airlines', 'UAL', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (2, 'American Airlines', 'AAL', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (3, 'United Airlines', 'UAL', 'USA');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (1, 500, 'LAX', 'ORD');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (1, 100, 'ORD', 'LAX');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (2, 200, 'LAX', 'ORD');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (3, 100, 'LAX', 'ORD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "flightno" FROM (SELECT "LHS"."uid" AS "uid", "LHS"."airline" AS "airline", "LHS"."abbreviation" AS "abbreviation", "LHS"."country" AS "country", "RHS"."flightno" AS "flightno", "RHS"."sourceairport" AS "sourceairport", "RHS"."destairport" AS "destairport" FROM (SELECT * FROM "airlines" WHERE ("airline" = 'United Airlines')) AS LHS INNER JOIN flights AS RHS ON (LHS.uid = RHS.airline)) ORDER BY flightno, "flightno" NULLS LAST;

/*
Gold Result:
(100,)
(100,)
(500,)
*/

-- Prediction Query
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRLINES AS T2 ON T2.uid = T1.Airline WHERE T2.Airline = 'United Airlines';

/*
Prediction Result:
(100,)
(500,)
(100,)
*/