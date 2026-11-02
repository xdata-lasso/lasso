-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY clauses: killed ASC (NULLS FIRST by default in SQLite), secondary sort on injured ASC NULLS LAST, and duplicate row preservation (SELECT ALL vs DISTINCT).
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (10, NULL, 'Ship Sort', 't', 'Destroyer', 'Pacific', 'Active');
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (1, 10, 'Row 1', 10, 5);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (2, 10, 'Row 2 (Tie killed, lower injured)', 10, 2);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (3, 10, 'Row 3 (Tie killed, null injured)', 10, NULL);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (4, 10, 'Row 4 (Duplicate of Row 1)', 10, 5);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (5, 10, 'Row 5 (Lower killed)', 2, 100);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (6, 10, 'Row 6 (Null killed, high injured)', NULL, 50);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (7, 10, 'Row 7 (Null killed, low injured)', NULL, 10);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (8, 10, 'Row 8 (Both null)', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "killed", "injured" FROM (SELECT "LHS"."caused_by_ship_id" AS "caused_by_ship_id", "LHS"."id" AS "id", "LHS"."note" AS "note", "LHS"."killed" AS "killed", "LHS"."injured" AS "injured", "RHS"."lost_in_battle" AS "lost_in_battle", "RHS"."name" AS "name", "RHS"."tonnage" AS "tonnage", "RHS"."ship_type" AS "ship_type", "RHS"."location" AS "location", "RHS"."disposition_of_ship" AS "disposition_of_ship" FROM "death" AS "LHS" INNER JOIN (SELECT * FROM "ship" WHERE ("tonnage" = 't')) AS RHS ON (LHS.caused_by_ship_id = RHS.id)) ORDER BY killed, "killed" NULLS LAST, "injured" NULLS LAST;

/*
Gold Result:
(None, 10)
(None, 50)
(None, None)
(2, 100)
(10, 2)
(10, 5)
(10, 5)
(10, None)
*/

-- Prediction Query
SELECT T1.killed, T1.injured FROM death AS T1 JOIN ship AS t2 ON T1.caused_by_ship_id = T2.id WHERE T2.tonnage = 't';

/*
Prediction Result:
(10, 5)
(10, 2)
(10, None)
(10, 5)
(2, 100)
(None, 50)
(None, 10)
(None, None)
*/