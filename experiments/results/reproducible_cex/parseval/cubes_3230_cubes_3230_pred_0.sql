-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1, 'rhs_ec6199', 'rhs_319c2c', 'United States', 1);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483647, 'rhs_7945e7', 'rhs_2d403f', 'United States', 1);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (3, 'rhs_ec6199', 'rhs_319c2c', 'United States', 1);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (2, '5k5swwqcgs', '9n8', '4', -734455130);

-- Inserting into table: mission --
INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (1, 1, 'lhs_3d6ab9', 1, 'lhs_9a9ce3', 1, 'lhs_a4935b');

INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (-2147483647, 1, 'lhs_efe735', 1, 'lhs_e47883', 1, 'lhs_299e0e');

INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (-2147483646, 1, 'lhs_efe735', 1, 'lhs_e47883', 1, 'lhs_299e0e');

INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (-2147483645, 1, 'lhs_efe735', 1, 'lhs_e47883', 1, 'lhs_299e0e');

INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (-2147483644, 1, 'lhs_efe735', 1, 'lhs_e47883', 1, 'lhs_299e0e');

INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (-2147483643, 1, 'lhs_efe735', 1, 'lhs_e47883', 1, 'lhs_299e0e');

INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (-2147483642, 1, 'lhs_efe735', 1, 'lhs_e47883', 1, 'lhs_299e0e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fate" FROM (SELECT "LHS"."mission_id" AS "mission_id", "LHS"."ship_id" AS "ship_id", "LHS"."code" AS "code", "LHS"."launched_year" AS "launched_year", "LHS"."location" AS "location", "LHS"."speed_knots" AS "speed_knots", "LHS"."fate" AS "fate", "RHS"."name" AS "name", "RHS"."type" AS "type", "RHS"."nationality" AS "nationality", "RHS"."tonnage" AS "tonnage" FROM "mission" AS "LHS" INNER JOIN "ship" AS "RHS" ON ("LHS"."ship_id" = "RHS"."ship_id")) WHERE ("nationality" = 'United States') ORDER BY fate, "fate" NULLS LAST;

/*
Gold Result:
('lhs_299e0e',)
('lhs_299e0e',)
('lhs_299e0e',)
('lhs_299e0e',)
('lhs_299e0e',)
('lhs_299e0e',)
('lhs_a4935b',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fate FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID WHERE T2.Nationality = 'United States';

/*
Prediction Result:
('lhs_299e0e',)
('lhs_a4935b',)
*/