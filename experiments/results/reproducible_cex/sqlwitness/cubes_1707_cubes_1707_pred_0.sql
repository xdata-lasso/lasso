-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO operate_company (id, name, type, principal_activities, incorporated_in, group_equity_shareholding) VALUES (1, 'default1', NULL, 'default1', NULL, NULL);
INSERT INTO airport (id, city, country, iata, icao, name) VALUES (2, 'default2', 'default2', NULL, 'default2', NULL);
INSERT INTO flight (id, company_id, airport_id, vehicle_flight_number, date, pilot, velocity, altitude) VALUES (1, 1, 2, NULL, 'default2', 'default2', 2.0, 2.0), (2, NULL, NULL, 'default1', 'default2', NULL, 1.0, 1.0);
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
('default2',)
*/