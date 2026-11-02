-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (5, 'Battle of Rodosto', '1206-02-12', 'Kaloyan', 'Henry of Flanders', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (6, 'Battle of Messinopolis', '1207-09-04', 'Kaloyan', 'Boniface of Montferrat', 'Bulgarian victory');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (101, 5, 'HMS Falcon', '250', 'Brig', 'Aegean Sea', 'Sunk');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (102, 5, 'HMS Hawk', '275', 'Brig', 'Aegean Sea', 'Burned');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (103, 6, 'HMS Eagle', '300', 'Brig', 'Black Sea', 'Captured');
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (1, 101, 'Explosion', 12, 5);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (2, 101, 'Fire', 4, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lost_in_battle" AS "id", "name_other" AS "name" FROM (SELECT "LHS"."lost_in_battle" AS "lost_in_battle", "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."tonnage" AS "tonnage", "LHS"."ship_type" AS "ship_type", "LHS"."location" AS "location", "LHS"."disposition_of_ship" AS "disposition_of_ship", "RHS"."name" AS "name_other", "RHS"."date" AS "date", "RHS"."bulgarian_commander" AS "bulgarian_commander", "RHS"."latin_commander" AS "latin_commander", "RHS"."result" AS "result" FROM (SELECT * FROM "ship" WHERE ("ship_type" = 'Brig')) AS LHS INNER JOIN battle AS RHS ON (LHS.lost_in_battle = RHS.id)) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(5, 'Battle of Rodosto')
(5, 'Battle of Rodosto')
(6, 'Battle of Messinopolis')
*/

-- Prediction Query
SELECT DISTINCT T1.id, T1.name FROM battle AS T1 JOIN ship AS T2 ON T1.id = T2.lost_in_battle WHERE T2.ship_type = 'Brig';

/*
Prediction Result:
(5, 'Battle of Rodosto')
(6, 'Battle of Messinopolis')
*/