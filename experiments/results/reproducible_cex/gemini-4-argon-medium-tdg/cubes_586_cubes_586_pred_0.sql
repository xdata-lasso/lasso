-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (5, 'Battle A', '1200', 'Cmdr 1', 'Cmdr 2', 'Win');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (15, 'Battle B', '1201', 'Cmdr 3', 'Cmdr 4', 'Loss');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (101, 5, 'Swift', '200', 'Brig', 'Loc 1', 'Sunk');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (102, 5, 'Bold', '220', 'Brig', 'Loc 2', 'Captured');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (103, 15, 'Eagle', '180', 'Brig', 'Loc 3', 'Sunk');
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (1, 103, 'Note 1', 10, 5);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (2, 103, 'Note 2', 20, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lost_in_battle" AS "id", "name_other" AS "name" FROM (SELECT "LHS"."lost_in_battle" AS "lost_in_battle", "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."tonnage" AS "tonnage", "LHS"."ship_type" AS "ship_type", "LHS"."location" AS "location", "LHS"."disposition_of_ship" AS "disposition_of_ship", "RHS"."name" AS "name_other", "RHS"."date" AS "date", "RHS"."bulgarian_commander" AS "bulgarian_commander", "RHS"."latin_commander" AS "latin_commander", "RHS"."result" AS "result" FROM (SELECT * FROM "ship" WHERE ("ship_type" = 'Brig')) AS LHS INNER JOIN battle AS RHS ON (LHS.lost_in_battle = RHS.id)) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(5, 'Battle A')
(5, 'Battle A')
(15, 'Battle B')
*/

-- Prediction Query
SELECT DISTINCT T1.id, T1.name FROM battle AS T1 JOIN ship AS T2 ON T1.id = T2.lost_in_battle WHERE T2.ship_type = 'Brig';

/*
Prediction Result:
(5, 'Battle A')
(15, 'Battle B')
*/