-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO operate_company (id, name, type, principal_activities, incorporated_in, group_equity_shareholding) VALUES (1, 'default1', 'default2', 'default2', NULL, 1.0);
INSERT INTO airport (id, city, country, iata, icao, name) VALUES (1, 'default1', 'default2', 'Thompson', 'Thompson', 'default1');
INSERT INTO flight (id, company_id, airport_id, vehicle_flight_number, date, pilot, velocity, altitude) VALUES (1, NULL, NULL, 'default1', NULL, 'Thompson', 0.0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "company_id" AS "count___" FROM (SELECT "LHS"."id" AS "id", "LHS"."city" AS "city", "LHS"."country" AS "country", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."name" AS "name", "LHS"."vehicle_flight_number" AS "vehicle_flight_number", "LHS"."date" AS "date", "LHS"."pilot" AS "pilot", "LHS"."velocity" AS "velocity", "LHS"."altitude" AS "altitude", "LHS"."airport_id" AS "airport_id", "LHS"."company_id" AS "company_id", "RHS"."n" AS "n" FROM (SELECT "LHS"."id" AS "id", "LHS"."city" AS "city", "LHS"."country" AS "country", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."name" AS "name", "RHS"."vehicle_flight_number" AS "vehicle_flight_number", "RHS"."date" AS "date", "RHS"."pilot" AS "pilot", "RHS"."velocity" AS "velocity", "RHS"."altitude" AS "altitude", "RHS"."airport_id" AS "airport_id", "RHS"."company_id" AS "company_id" FROM "airport" AS "LHS" INNER JOIN "flight" AS "RHS" ON ("LHS"."id" = "RHS"."id")) AS "LHS" INNER JOIN (SELECT "airport_id", COUNT(*) AS "n" FROM "flight" GROUP BY "airport_id") AS "RHS" ON ("LHS"."airport_id" = "RHS"."airport_id")) WHERE ("pilot" = 'Thompson' AND n > id) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM airport WHERE NOT id IN (SELECT airport_id FROM flight WHERE pilot = 'Thompson');

/*
Prediction Result:
(0,)
*/