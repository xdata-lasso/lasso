-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (25, 'United States20', 'Billund Airport21', 'United States22', 'Billund Airport23', 'Billund Airport');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (36, 'United States30', 'Billund Airport31', 'United States32', 'Billund Airport33', 'Billund Airport');
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (24, 'Billund Airport25', 'Billund Airport25', 'Billund Airport25', 'Billund Airport25', 25);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (35, 'Billund Airport25', 'Billund Airport25', 'Billund Airport25', 'Billund Airport25', 25);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (25, 24, 25, 'United States26', 'Billund Airport27', 'Billund Airport41', 28, 29);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (34, 35, 36, 'Billund Airport37', 'United States38', NULL, 39, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "pilot" FROM (SELECT "LHS"."id" AS "id", "LHS"."city" AS "city", "LHS"."country" AS "country", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."name" AS "name", "RHS"."vehicle_flight_number" AS "vehicle_flight_number", "RHS"."date" AS "date", "RHS"."pilot" AS "pilot", "RHS"."velocity" AS "velocity", "RHS"."altitude" AS "altitude", "RHS"."airport_id" AS "airport_id", "RHS"."company_id" AS "company_id" FROM "airport" AS "LHS" INNER JOIN "flight" AS "RHS" ON ("LHS"."id" = "RHS"."id")) WHERE ("country" <> 'United States' OR "name" <> 'Billund Airport') ORDER BY pilot, "pilot" NULLS LAST;

/*
Gold Result:
('Billund Airport41',)
*/

-- Prediction Query
SELECT DISTINCT T2.pilot FROM airport AS T1 JOIN flight AS T2 ON T1.id = T2.airport_id WHERE T1.country = 'United States' OR T1.name = 'Billund Airport';

/*
Prediction Result:
('Billund Airport41',)
(None,)
*/