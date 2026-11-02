-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "airports" ("AirportCode", "City", "AirportName", "Country", "CountryAbbrev") VALUES ('AP1', 'City1', 'Airport1', 'Country1', 'C1');
INSERT INTO "airports" ("AirportCode", "City", "AirportName", "Country", "CountryAbbrev") VALUES ('AP2', 'City2', 'Airport2', 'Country2', 'C2');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (10, 'Alpha Air', 'AA', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (20, 'Beta Air', 'BA', 'USA');
INSERT INTO "airlines" ("uid", "Airline", "Abbreviation", "Country") VALUES (21, 'Beta Air', 'BA2', 'UK');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (10, 5, 'AP1', 'AP2');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (2, 10, 'AP1', 'AP2');
INSERT INTO "flights" ("Airline", "FlightNo", "DestAirport", "SourceAirport") VALUES (1, 20, 'AP2', 'AP1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airline_other AS airline FROM (SELECT * FROM (SELECT * FROM (SELECT airline, flightno, sourceairport, destairport, airline_other, airline AS n FROM (SELECT LHS.airline AS airline, LHS.flightno AS flightno, LHS.sourceairport AS sourceairport, LHS.destairport AS destairport, RHS.airline AS airline_other FROM flights AS LHS INNER JOIN (SELECT airline, COUNT(*) AS n FROM airlines GROUP BY airline) AS RHS ON (LHS.airline = RHS.n))) ORDER BY flightno) LIMIT 1);

/*
Gold Result:
('Beta Air',)
*/

-- Prediction Query
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid = T2.Airline GROUP BY T1.Airline ORDER BY COUNT(*) DESC, T1.Airline NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha Air',)
*/