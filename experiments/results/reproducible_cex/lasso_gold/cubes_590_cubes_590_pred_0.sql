-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1117, 'Christopher Mcdonald', 'care', 'prevent', 'none', 'agreement');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1122, 'Bradley Smith', 'notice', 'area', 'hard', 'door');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (1118, 1117, 'Leslie Alvarado', 't', 'because', '2046 Lewis Islands
Kathleenfurt, KY 99068', 'theory');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (1123, 1122, 'Rachael Pearson', 't', 'somebody', '09232 Caldwell Port
South Holly, WI 48852', 'computer');
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (1119, 1118, 'know', 1121, 1121);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (1124, 1123, 'police', 1120, 1122);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "killed", "injured" FROM (SELECT "LHS"."caused_by_ship_id" AS "caused_by_ship_id", "LHS"."id" AS "id", "LHS"."note" AS "note", "LHS"."killed" AS "killed", "LHS"."injured" AS "injured", "RHS"."lost_in_battle" AS "lost_in_battle", "RHS"."name" AS "name", "RHS"."tonnage" AS "tonnage", "RHS"."ship_type" AS "ship_type", "RHS"."location" AS "location", "RHS"."disposition_of_ship" AS "disposition_of_ship" FROM "death" AS "LHS" INNER JOIN (SELECT * FROM "ship" WHERE ("tonnage" = 't')) AS RHS ON (LHS.caused_by_ship_id = RHS.id)) ORDER BY killed, "killed" NULLS LAST, "injured" NULLS LAST;

/*
Gold Result:
(1120, 1122)
(1121, 1121)
*/

-- Prediction Query
SELECT T1.killed, T1.injured FROM death AS T1 JOIN ship AS t2 ON T1.caused_by_ship_id = T2.id WHERE T2.tonnage = 't';

/*
Prediction Result:
(1121, 1121)
(1120, 1122)
*/