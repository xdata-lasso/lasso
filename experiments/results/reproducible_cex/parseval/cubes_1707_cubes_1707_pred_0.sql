-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airport --
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483648, '4h', 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'dpos');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1, 'e', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r');

-- Inserting into table: operate_company --
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366);

INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', 262.105498);

-- Inserting into table: flight --
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1, -2147483648, -2147483648, 'ie5', 'nw6klf', 'a9000t5c4eci', 1.0, 734.586266);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (2, -2147483648, 1, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', 598.428216, 949.322482);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (3, 1, -2147483648, 'a7ryfd', 'z16ni', 'jai', 906.609226, 62.386264);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (4, -2147483648, 1, 'grgj', '8', 'yzt1afgogrit', 743.920586, 657.87028);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (5, -2147483648, 1, 'y', 'p1q430', 'jh3den8', 596.764785, 46.611179);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (6, 1, 1, 'c', 'x7afu5w1of77', 'zo72', 752.977863, 723.045103);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (7, -2147483648, 1, 'c', 'mfg62', '0v', 492.883123, 691.147113);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT pilot FROM (SELECT airport_id, velocity, n, vehicle_flight_number, date, pilot, velocity_other, altitude, company_id, airport_id AS id FROM (SELECT LHS.airport_id AS airport_id, LHS.velocity AS velocity, LHS.n AS n, RHS.vehicle_flight_number AS vehicle_flight_number, RHS.date AS date, RHS.pilot AS pilot, RHS.velocity AS velocity_other, RHS.altitude AS altitude, RHS.company_id AS company_id FROM (SELECT airport_id, velocity, COUNT(*) AS n FROM flight GROUP BY airport_id, velocity) AS LHS INNER JOIN flight AS RHS ON (LHS.airport_id = RHS.id AND LHS.n = RHS.airport_id))) ORDER BY pilot;

/*
Gold Result:
*/

-- Prediction Query
SELECT pilot FROM flight GROUP BY pilot ORDER BY COUNT(*) DESC, pilot NULLS LAST LIMIT 1;

/*
Prediction Result:
('0v',)
*/