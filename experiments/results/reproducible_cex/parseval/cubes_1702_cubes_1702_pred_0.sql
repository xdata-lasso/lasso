-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airport --
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1, 'lhs_4e2510', 'lhs_29f1d2', 'lhs_3b202a', 'lhs_3113ac', 'lhs_fd056e');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483647, 'lhs_b0ca2b', 'lhs_aceac0', 'lhs_37659c', 'lhs_a9b091', 'lhs_58638f');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (2, 'lhs_4e2510', 'lhs_29f1d2', 'lhs_3b202a', 'lhs_3113ac', 'lhs_fd056e');

-- Inserting into table: operate_company --
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366);

INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1, 'tilbn', 'rmdp', 'siie', 'unw6klfa', 587.783596);

-- Inserting into table: flight --
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1, -2147483648, 1, '4h', 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483647, 1, 1, '0t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 586.906897, 389.878901);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (3, 1, 1, 'rhs_130021', 'rhs_a0e46c', 'Thompson', 1.0, 1.0);
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
(2,)
*/