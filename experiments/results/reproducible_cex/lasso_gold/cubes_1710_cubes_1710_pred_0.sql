-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1073, 'New Angelashire', 'Cyprus', 'account', 'avoid', 'Amy Jones');
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1074, 'Gary Palmer', 'family', 'Cargo', 'relationship', 1075.5);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1080, 'Gary Palmer', 'family', 'Cargo', 'relationship', 1075.5);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1076, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1076, 1076, 1073, 'mention', 'difficult', 'notice', 1077.5, 1078.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1079, 1080, 1073, 'mention', 'difficult', 'notice', 1077.5, 1078.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pilot" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."type" AS "type", "LHS"."principal_activities" AS "principal_activities", "LHS"."incorporated_in" AS "incorporated_in", "LHS"."group_equity_shareholding" AS "group_equity_shareholding", "RHS"."id" AS "id_other", "RHS"."vehicle_flight_number" AS "vehicle_flight_number", "RHS"."date" AS "date", "RHS"."pilot" AS "pilot", "RHS"."velocity" AS "velocity", "RHS"."altitude" AS "altitude", "RHS"."airport_id" AS "airport_id" FROM (SELECT * FROM "operate_company" WHERE ("principal_activities" = 'Cargo' AND "principal_activities" <> 'Catering services')) AS LHS INNER JOIN flight AS RHS ON (LHS.id = RHS.company_id)) ORDER BY pilot, "pilot" NULLS LAST;

/*
Gold Result:
('notice',)
*/

-- Prediction Query
SELECT T2.pilot FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id WHERE T1.principal_activities = 'Cargo' INTERSECT SELECT T2.pilot FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id WHERE T1.principal_activities = 'Catering services';

/*
Prediction Result:
*/