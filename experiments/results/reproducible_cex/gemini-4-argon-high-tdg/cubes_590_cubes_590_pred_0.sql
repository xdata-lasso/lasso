-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1, 'Battle A', '1205', 'Kaloyan', 'Baldwin', 'Victory');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (1, 1, 'Alpha', 't', 'Brig', 'Sea', 'Captured');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (2, 1, 't', '225', 't', 't', 't');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (3, NULL, 'Beta', 't', 'Galleon', 'Port', 'Sunk');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (4, 1, 'Gamma', 't', 'Brig', 'Bay', 'Active');
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (1, 1, 'Note 1', 25, 10);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (2, 2, 'Note 2', 5, 50);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (3, 3, 'Note 3', 12, 30);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (4, NULL, 'Note 4', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "killed", "injured" FROM (SELECT "LHS"."caused_by_ship_id" AS "caused_by_ship_id", "LHS"."id" AS "id", "LHS"."note" AS "note", "LHS"."killed" AS "killed", "LHS"."injured" AS "injured", "RHS"."lost_in_battle" AS "lost_in_battle", "RHS"."name" AS "name", "RHS"."tonnage" AS "tonnage", "RHS"."ship_type" AS "ship_type", "RHS"."location" AS "location", "RHS"."disposition_of_ship" AS "disposition_of_ship" FROM "death" AS "LHS" INNER JOIN (SELECT * FROM "ship" WHERE ("tonnage" = 't')) AS RHS ON (LHS.caused_by_ship_id = RHS.id)) ORDER BY killed, "killed" NULLS LAST, "injured" NULLS LAST;

/*
Gold Result:
(12, 30)
(25, 10)
*/

-- Prediction Query
SELECT T1.killed, T1.injured FROM death AS T1 JOIN ship AS t2 ON T1.caused_by_ship_id = T2.id WHERE T2.tonnage = 't';

/*
Prediction Result:
(25, 10)
(12, 30)
*/