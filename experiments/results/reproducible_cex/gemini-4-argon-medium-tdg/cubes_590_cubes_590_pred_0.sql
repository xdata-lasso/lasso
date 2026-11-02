-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests complex ORDER BY behaviors: ASC vs DESC, secondary sort on "injured", and NULLS FIRST vs NULLS LAST on both "killed" and "injured".
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (10, NULL, 'Zeta', 't', 'Frigate', 'Mediterranean', 'Sunk');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (20, NULL, 'Eta', 't', 'Sloop', 'Adriatic', 'Captured');
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (101, 10, 'Row 1', 5, 10);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (102, 10, 'Row 2', 5, 2);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (103, 20, 'Row 3', 5, NULL);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (104, 10, 'Row 4', 1, 50);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (105, 20, 'Row 5', NULL, 20);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (106, 20, 'Row 6', NULL, 5);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (107, 10, 'Row 7', NULL, NULL);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (108, 10, 'Row 8', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "killed", "injured" FROM (SELECT "LHS"."caused_by_ship_id" AS "caused_by_ship_id", "LHS"."id" AS "id", "LHS"."note" AS "note", "LHS"."killed" AS "killed", "LHS"."injured" AS "injured", "RHS"."lost_in_battle" AS "lost_in_battle", "RHS"."name" AS "name", "RHS"."tonnage" AS "tonnage", "RHS"."ship_type" AS "ship_type", "RHS"."location" AS "location", "RHS"."disposition_of_ship" AS "disposition_of_ship" FROM "death" AS "LHS" INNER JOIN (SELECT * FROM "ship" WHERE ("tonnage" = 't')) AS RHS ON (LHS.caused_by_ship_id = RHS.id)) ORDER BY killed, "killed" NULLS LAST, "injured" NULLS LAST;

/*
Gold Result:
(None, 5)
(None, 20)
(None, None)
(0, 0)
(1, 50)
(5, 2)
(5, 10)
(5, None)
*/

-- Prediction Query
SELECT T1.killed, T1.injured FROM death AS T1 JOIN ship AS t2 ON T1.caused_by_ship_id = T2.id WHERE T2.tonnage = 't';

/*
Prediction Result:
(5, 10)
(5, 2)
(5, None)
(1, 50)
(None, 20)
(None, 5)
(None, None)
(0, 0)
*/