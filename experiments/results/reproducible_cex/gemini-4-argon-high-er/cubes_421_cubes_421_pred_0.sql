-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airports (AirportCode, City, AirportName, Country, CountryAbbrev) VALUES ('A1', 'City1', 'Airport1', 'USA', 'US');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (1, 'United Airlines', 'UA', 'USA');
INSERT INTO airlines (uid, Airline, Abbreviation, Country) VALUES (2, 'United Airlines', 'UA', 'USA');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (1, 20, 'A1', 'A1');
INSERT INTO flights (Airline, FlightNo, DestAirport, SourceAirport) VALUES (2, 10, 'A1', 'A1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "flightno" FROM (SELECT "LHS"."uid" AS "uid", "LHS"."airline" AS "airline", "LHS"."abbreviation" AS "abbreviation", "LHS"."country" AS "country", "RHS"."flightno" AS "flightno", "RHS"."sourceairport" AS "sourceairport", "RHS"."destairport" AS "destairport" FROM (SELECT * FROM "airlines" WHERE ("airline" = 'United Airlines')) AS LHS INNER JOIN flights AS RHS ON (LHS.uid = RHS.airline)) ORDER BY flightno, "flightno" NULLS LAST;

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRLINES AS T2 ON T2.uid = T1.Airline WHERE T2.Airline = 'United Airlines';

/*
Prediction Result:
(20,)
(10,)
*/