-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'USS Enterprise', 'Carrier', 'United States', 80000);
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (1, 1, 'M1', 1940, 'Pacific', 30, 'Sunk');
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (2, 1, 'M2', 1942, 'Atlantic', 28, 'Sunk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fate" FROM (SELECT "LHS"."mission_id" AS "mission_id", "LHS"."ship_id" AS "ship_id", "LHS"."code" AS "code", "LHS"."launched_year" AS "launched_year", "LHS"."location" AS "location", "LHS"."speed_knots" AS "speed_knots", "LHS"."fate" AS "fate", "RHS"."name" AS "name", "RHS"."type" AS "type", "RHS"."nationality" AS "nationality", "RHS"."tonnage" AS "tonnage" FROM "mission" AS "LHS" INNER JOIN "ship" AS "RHS" ON ("LHS"."ship_id" = "RHS"."ship_id")) WHERE ("nationality" = 'United States') ORDER BY fate, "fate" NULLS LAST;

/*
Gold Result:
('Sunk',)
('Sunk',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fate FROM mission AS T1 JOIN ship AS T2 ON T1.Ship_ID = T2.Ship_ID WHERE T2.Nationality = 'United States';

/*
Prediction Result:
('Sunk',)
*/