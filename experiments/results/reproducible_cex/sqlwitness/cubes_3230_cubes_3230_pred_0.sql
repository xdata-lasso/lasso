-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, nationality, tonnage) VALUES (0, NULL, 'default1', 'United States', 1);
INSERT INTO mission (mission_id, ship_id, code, launched_year, location, speed_knots, fate) VALUES (1, 0, 'default1', NULL, 'United States', NULL, 'default2'), (0, NULL, 'default1', 1, 'default2', NULL, 'United States'), (2, 0, NULL, 0, NULL, NULL, NULL), (3, 0, 'United States', 1, 'default2', NULL, NULL), (4, 0, 'default2', 0, NULL, NULL, 'default2'), (5, NULL, 'default1', 0, 'default2', 1, 'default1'), (6, 0, 'default1', NULL, 'default1', NULL, NULL), (7, NULL, 'default2', NULL, 'default1', NULL, 'United States'), (8, 0, 'United States', 0, 'United States', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fate" FROM (SELECT "LHS"."mission_id" AS "mission_id", "LHS"."ship_id" AS "ship_id", "LHS"."code" AS "code", "LHS"."launched_year" AS "launched_year", "LHS"."location" AS "location", "LHS"."speed_knots" AS "speed_knots", "LHS"."fate" AS "fate", "RHS"."name" AS "name", "RHS"."type" AS "type", "RHS"."nationality" AS "nationality", "RHS"."tonnage" AS "tonnage" FROM "mission" AS "LHS" INNER JOIN "ship" AS "RHS" ON ("LHS"."ship_id" = "RHS"."ship_id")) WHERE ("nationality" = 'United States') ORDER BY fate, "fate" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fate FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID WHERE T2.Nationality = 'United States';

/*
Prediction Result:
('default2',)
(None,)
('default1',)
*/