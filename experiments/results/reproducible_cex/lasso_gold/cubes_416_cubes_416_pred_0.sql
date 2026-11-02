-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1123, 'traditional', 'among', 'United Arab Emirates');
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1127, 'its', 'suffer', 'Paraguay');
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('help', 'Lake John', 'Richard Henson', 'Ireland', 'Niger');
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('treat', 'West Erik', 'Janet Williams', 'Latvia', 'Cyprus');
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('so', NULL, NULL, NULL, NULL);
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('economic', NULL, NULL, NULL, NULL);
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('word', NULL, NULL, NULL, NULL);
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('decision', NULL, NULL, NULL, NULL);
INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, 1124, 'help', 'so');
INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, 1126, 'economic', 'word');
INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, 1128, 'treat', 'decision');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airline_other AS airline FROM (SELECT * FROM (SELECT * FROM (SELECT airline, flightno, sourceairport, destairport, airline_other, airline AS n FROM (SELECT LHS.airline AS airline, LHS.flightno AS flightno, LHS.sourceairport AS sourceairport, LHS.destairport AS destairport, RHS.airline AS airline_other FROM flights AS LHS INNER JOIN (SELECT airline, COUNT(*) AS n FROM airlines GROUP BY airline) AS RHS ON (LHS.airline = RHS.n))) ORDER BY flightno) LIMIT 1);

/*
Gold Result:
('its',)
*/

-- Prediction Query
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid = T2.Airline GROUP BY T1.Airline ORDER BY COUNT(*) DESC, T1.Airline NULLS LAST LIMIT 1;

/*
Prediction Result:
*/