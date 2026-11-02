-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (0, 'default1', NULL, NULL, 'default2', 'default1'), (1, 'default2', 'default2', 'default2', NULL, 't'), (2, 'default2', 'default2', NULL, 'default2', NULL), (3, NULL, 'default1', 'default1', NULL, NULL), (4, 'default2', 'default1', NULL, 'default2', NULL), (5, 'default2', 't', NULL, 'default2', 't'), (6, NULL, NULL, 'default1', 't', NULL), (7, 'default1', NULL, 't', 'default2', 'default2'), (8, 't', NULL, 't', 't', 'default1'), (9, 'default2', 'default2', NULL, 'default2', 'default1'), (10, 'default2', 'default1', NULL, 'default1', 'default1'), (11, NULL, 't', 't', 't', 'default2'), (12, 'default2', 'default2', 't', 't', 't');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (1, 9, 't', 'default1', 'default2', 't', NULL), (0, 11, 'default1', 't', 'default1', 'default2', 't'), (2, NULL, 't', NULL, 'default1', 'default2', 'default1'), (3, 3, 'default1', 't', 'default1', NULL, 'default2'), (4, 10, 'default2', 'default1', 'default2', 't', 'default1'), (5, 0, 't', 'default2', 'default2', 'default2', NULL), (6, 3, 'default2', NULL, 't', 'default2', NULL), (7, 12, 'default1', 't', NULL, NULL, 't'), (8, 3, 'default2', 't', 't', NULL, 'default1'), (9, 5, NULL, NULL, 't', 'default1', 'default2'), (10, 4, 'default1', 'default2', 'default2', 'default1', 'default2'), (11, 6, 'default2', 't', 'default2', 'default1', 't'), (12, 5, NULL, 'default2', NULL, 'default1', 't'), (13, 11, 'default1', NULL, 'default1', 't', 'default1'), (14, 6, NULL, NULL, NULL, NULL, 't');
INSERT INTO death (id, caused_by_ship_id, note, killed, injured) VALUES (0, 8, 'default1', NULL, 1), (1, 2, 'default1', 0, 1), (2, 3, NULL, NULL, 0), (3, 12, NULL, 1, 0), (4, 7, NULL, 0, 1), (5, 4, 'default2', NULL, 1), (6, 1, 'default1', 0, 0), (7, 12, 'default2', 1, 0), (8, 11, 'default1', 1, 0), (9, 14, 'default1', NULL, 0), (10, 6, NULL, 1, 1), (11, NULL, NULL, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "killed", "injured" FROM (SELECT "LHS"."caused_by_ship_id" AS "caused_by_ship_id", "LHS"."id" AS "id", "LHS"."note" AS "note", "LHS"."killed" AS "killed", "LHS"."injured" AS "injured", "RHS"."lost_in_battle" AS "lost_in_battle", "RHS"."name" AS "name", "RHS"."tonnage" AS "tonnage", "RHS"."ship_type" AS "ship_type", "RHS"."location" AS "location", "RHS"."disposition_of_ship" AS "disposition_of_ship" FROM "death" AS "LHS" INNER JOIN (SELECT * FROM "ship" WHERE ("tonnage" = 't')) AS RHS ON (LHS.caused_by_ship_id = RHS.id)) ORDER BY killed, "killed" NULLS LAST, "injured" NULLS LAST;

/*
Gold Result:
(None, 0)
(None, 1)
(0, 1)
(1, 0)
*/

-- Prediction Query
SELECT T1.killed, T1.injured FROM death AS T1 JOIN ship AS t2 ON T1.caused_by_ship_id = T2.id WHERE T2.tonnage = 't';

/*
Prediction Result:
(None, 1)
(None, 0)
(0, 1)
(1, 0)
*/