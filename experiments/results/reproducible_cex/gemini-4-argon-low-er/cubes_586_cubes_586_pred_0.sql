-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "battle" ("id", "name") VALUES (1, 'Battle 1');
INSERT INTO "ship" ("id", "lost_in_battle", "ship_type") VALUES (1, 1, 'Brig');
INSERT INTO "ship" ("id", "lost_in_battle", "ship_type") VALUES (2, 1, 'Brig');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lost_in_battle" AS "id", "name_other" AS "name" FROM (SELECT "LHS"."lost_in_battle" AS "lost_in_battle", "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."tonnage" AS "tonnage", "LHS"."ship_type" AS "ship_type", "LHS"."location" AS "location", "LHS"."disposition_of_ship" AS "disposition_of_ship", "RHS"."name" AS "name_other", "RHS"."date" AS "date", "RHS"."bulgarian_commander" AS "bulgarian_commander", "RHS"."latin_commander" AS "latin_commander", "RHS"."result" AS "result" FROM (SELECT * FROM "ship" WHERE ("ship_type" = 'Brig')) AS LHS INNER JOIN battle AS RHS ON (LHS.lost_in_battle = RHS.id)) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(1, 'Battle 1')
(1, 'Battle 1')
*/

-- Prediction Query
SELECT DISTINCT T1.id, T1.name FROM battle AS T1 JOIN ship AS T2 ON T1.id = T2.lost_in_battle WHERE T2.ship_type = 'Brig';

/*
Prediction Result:
(1, 'Battle 1')
*/