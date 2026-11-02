-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1039, 'United Airlines', 'eight', 'Slovenia');
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1041, 'United Airlines', 'report', 'Palau');
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('material', 'Leeville', 'Heather Jenkins', 'Tonga', 'Saint Lucia');
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('race', 'North Richardmouth', 'Ashley Lee', 'Mauritania', 'Kiribati');
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('arm', NULL, NULL, NULL, NULL);
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('challenge', NULL, NULL, NULL, NULL);
INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1039, 1042, 'material', 'arm');
INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1041, 1040, 'race', 'challenge');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "flightno" FROM (SELECT "LHS"."uid" AS "uid", "LHS"."airline" AS "airline", "LHS"."abbreviation" AS "abbreviation", "LHS"."country" AS "country", "RHS"."flightno" AS "flightno", "RHS"."sourceairport" AS "sourceairport", "RHS"."destairport" AS "destairport" FROM (SELECT * FROM "airlines" WHERE ("airline" = 'United Airlines')) AS LHS INNER JOIN flights AS RHS ON (LHS.uid = RHS.airline)) ORDER BY flightno, "flightno" NULLS LAST;

/*
Gold Result:
(1040,)
(1042,)
*/

-- Prediction Query
SELECT T1.FlightNo FROM FLIGHTS AS T1 JOIN AIRLINES AS T2 ON T2.uid = T1.Airline WHERE T2.Airline = 'United Airlines';

/*
Prediction Result:
(1042,)
(1040,)
*/