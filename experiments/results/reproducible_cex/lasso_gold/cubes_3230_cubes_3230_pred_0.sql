-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1036, 'Mario Skinner', 'movement', 'United States', 1037);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1042, 'Mario Skinner', 'movement', 'United States', 1037);
INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (1038, 1036, 'politics', 1039, '88095 Smith Lake Suite 303
North Jessicaland, WV 70323', 1040, 'space');
INSERT INTO "mission" ("mission_id", "ship_id", "code", "launched_year", "location", "speed_knots", "fate") VALUES (1041, 1042, 'politics', 1039, '88095 Smith Lake Suite 303
North Jessicaland, WV 70323', 1040, 'space');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fate" FROM (SELECT "LHS"."mission_id" AS "mission_id", "LHS"."ship_id" AS "ship_id", "LHS"."code" AS "code", "LHS"."launched_year" AS "launched_year", "LHS"."location" AS "location", "LHS"."speed_knots" AS "speed_knots", "LHS"."fate" AS "fate", "RHS"."name" AS "name", "RHS"."type" AS "type", "RHS"."nationality" AS "nationality", "RHS"."tonnage" AS "tonnage" FROM "mission" AS "LHS" INNER JOIN "ship" AS "RHS" ON ("LHS"."ship_id" = "RHS"."ship_id")) WHERE ("nationality" = 'United States') ORDER BY fate, "fate" NULLS LAST;

/*
Gold Result:
('space',)
('space',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fate FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID WHERE T2.Nationality = 'United States';

/*
Prediction Result:
('space',)
*/