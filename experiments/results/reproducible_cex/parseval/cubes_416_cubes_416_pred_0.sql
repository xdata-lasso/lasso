-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airports --
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('airportcod_1', '4', 'gu7v', 'e4', 'hria2ypuzhs');

-- Inserting into table: airlines --
INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (1, 't1__6618f2', '5k5swwqcgs', '9n8');

INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (2, 't1__6618f2', 'wbbp6luhvdlt', 'ilbnp');

INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (3, 't1__6618f2', 'mdpos', 'ie5');

INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (-2147483645, 'G', '52zb', 'uo4nrqrofqy');

INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (-2147483644, 'O', '5bbp0', '2eutliqa11r');

INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (-2147483643, 'G', 'oo3o9', 'l7');

INSERT INTO "airlines" ("uid", "airline", "abbreviation", "country") VALUES (-2147483642, 'O', 'ex1', 'ji7zwau2');

-- Inserting into table: flights --
INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483648, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (2, -2147483647, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (2, -2147483646, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483645, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483644, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483643, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483642, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483641, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483640, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483639, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483638, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483637, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483636, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483635, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483634, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483633, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483632, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483631, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483630, 'airportcod_1', 'airportcod_1');

INSERT INTO "flights" ("airline", "flightno", "destairport", "sourceairport") VALUES (1, -2147483629, 'airportcod_1', 'airportcod_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airline_other AS airline FROM (SELECT * FROM (SELECT * FROM (SELECT airline, flightno, sourceairport, destairport, airline_other, airline AS n FROM (SELECT LHS.airline AS airline, LHS.flightno AS flightno, LHS.sourceairport AS sourceairport, LHS.destairport AS destairport, RHS.airline AS airline_other FROM flights AS LHS INNER JOIN (SELECT airline, COUNT(*) AS n FROM airlines GROUP BY airline) AS RHS ON (LHS.airline = RHS.n))) ORDER BY flightno) LIMIT 1);

/*
Gold Result:
('G',)
*/

-- Prediction Query
SELECT T1.Airline FROM AIRLINES AS T1 JOIN FLIGHTS AS T2 ON T1.uid = T2.Airline GROUP BY T1.Airline ORDER BY COUNT(*) DESC, T1.Airline NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__6618f2',)
*/