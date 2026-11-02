-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (0, 'North Judithbury', 'Czech Republic', 'chair', 'since', 'Patrick Gardner');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1009, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1001, 'Amanda Davis', 'list', 'table', 'song', 1004.5);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1002, 'Lance Hoffman', 'perform', 'true', 'sure', 1017.5);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1003, 'Meredith Barnes', 'fall', 'according', 'collection', 1030.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (0, 1001, 1009, 'save', 'clearly', 'Thompson', 1010.5, 1013.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1007, 1001, 1009, 'knowledge', 'dinner', 'Thompson', 1025.5, 1030.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1008, 1001, 1009, 'grow', 'source', 'Thompson', 1040.5, 1047.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1016, 1001, 1009, 'great', 'husband', 'throw', 1019.5, 1022.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1017, 1001, 1009, 'blue', 'bill', 'guy', 1034.5, 1039.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1018, 1001, 1009, 'best', 'her', 'PM', 1049.5, 1056.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "company_id" AS "count___" FROM (SELECT "LHS"."id" AS "id", "LHS"."city" AS "city", "LHS"."country" AS "country", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."name" AS "name", "LHS"."vehicle_flight_number" AS "vehicle_flight_number", "LHS"."date" AS "date", "LHS"."pilot" AS "pilot", "LHS"."velocity" AS "velocity", "LHS"."altitude" AS "altitude", "LHS"."airport_id" AS "airport_id", "LHS"."company_id" AS "company_id", "RHS"."n" AS "n" FROM (SELECT "LHS"."id" AS "id", "LHS"."city" AS "city", "LHS"."country" AS "country", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."name" AS "name", "RHS"."vehicle_flight_number" AS "vehicle_flight_number", "RHS"."date" AS "date", "RHS"."pilot" AS "pilot", "RHS"."velocity" AS "velocity", "RHS"."altitude" AS "altitude", "RHS"."airport_id" AS "airport_id", "RHS"."company_id" AS "company_id" FROM "airport" AS "LHS" INNER JOIN "flight" AS "RHS" ON ("LHS"."id" = "RHS"."id")) AS "LHS" INNER JOIN (SELECT "airport_id", COUNT(*) AS "n" FROM "flight" GROUP BY "airport_id") AS "RHS" ON ("LHS"."airport_id" = "RHS"."airport_id")) WHERE ("pilot" = 'Thompson' AND n > id) ORDER BY count___;

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT COUNT(*) FROM airport WHERE NOT id IN (SELECT airport_id FROM flight WHERE pilot = 'Thompson');

/*
Prediction Result:
(1,)
*/