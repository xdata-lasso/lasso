-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airport --
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (-2147483648, '5sw', 'qcgsk9', '8c4p', 'u7', 'fe4hri');

INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1, 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

-- Inserting into table: operate_company --
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1, 'ope_2db46f', 'ope_ea0ca8', 'Cargo', 'ope_4c794e', 1.0);

INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (-2147483647, 'ope_a9cd7e', 'ope_b5f76a', 'Cargo', 'ope_4a2984', 1.0);

-- Inserting into table: flight --
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1, 1, -2147483648, 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 240.969194, 267.815776);

INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (-2147483647, -2147483647, -2147483648, 'nrqrofqy', '5s5b', 'p', 705.580387, 673.065986);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pilot" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."type" AS "type", "LHS"."principal_activities" AS "principal_activities", "LHS"."incorporated_in" AS "incorporated_in", "LHS"."group_equity_shareholding" AS "group_equity_shareholding", "RHS"."id" AS "id_other", "RHS"."vehicle_flight_number" AS "vehicle_flight_number", "RHS"."date" AS "date", "RHS"."pilot" AS "pilot", "RHS"."velocity" AS "velocity", "RHS"."altitude" AS "altitude", "RHS"."airport_id" AS "airport_id" FROM (SELECT * FROM "operate_company" WHERE ("principal_activities" = 'Cargo' AND "principal_activities" <> 'Catering services')) AS LHS INNER JOIN flight AS RHS ON (LHS.id = RHS.company_id)) ORDER BY pilot, "pilot" NULLS LAST;

/*
Gold Result:
('n',)
('p',)
*/

-- Prediction Query
SELECT T2.pilot FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id WHERE T1.principal_activities = 'Cargo' INTERSECT SELECT T2.pilot FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id WHERE T1.principal_activities = 'Catering services';

/*
Prediction Result:
*/