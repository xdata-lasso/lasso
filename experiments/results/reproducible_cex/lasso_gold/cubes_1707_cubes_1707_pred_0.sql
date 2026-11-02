-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1, 'Robinsonshire', 'Fiji', 'table', 'true', 'Robert Wolfe');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1022, 'Lindsaymouth', 'Mauritania', 'capital', 'win', 'Juan Calderon');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1012, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1019, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1008, 'Christopher Bernard', 'great', 'blue', 'best', 1009.5);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1015, 'Shannon Ray', 'sea', 'available', 'answer', 1016.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1, 1008, 1, 'husband', 'bill', 'her', 1010.5, 1011.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1012, 1008, 1012, 'throw', 'guy', 'PM', 1013.5, 1014.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1023, NULL, 1, 'recently', 'drive', 'spring', 1017.5, 1018.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1019, NULL, 1019, 'figure', 'base', 'top', 1020.5, 1021.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT pilot FROM (SELECT airport_id, velocity, n, vehicle_flight_number, date, pilot, velocity_other, altitude, company_id, airport_id AS id FROM (SELECT LHS.airport_id AS airport_id, LHS.velocity AS velocity, LHS.n AS n, RHS.vehicle_flight_number AS vehicle_flight_number, RHS.date AS date, RHS.pilot AS pilot, RHS.velocity AS velocity_other, RHS.altitude AS altitude, RHS.company_id AS company_id FROM (SELECT airport_id, velocity, COUNT(*) AS n FROM flight GROUP BY airport_id, velocity) AS LHS INNER JOIN flight AS RHS ON (LHS.airport_id = RHS.id AND LHS.n = RHS.airport_id))) ORDER BY pilot;

/*
Gold Result:
('her',)
*/

-- Prediction Query
SELECT pilot FROM flight GROUP BY pilot ORDER BY COUNT(*) DESC, pilot NULLS LAST LIMIT 1;

/*
Prediction Result:
('PM',)
*/