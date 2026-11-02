-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO club (club_id, name, region, start_year) VALUES (1, 'default1', 'Right Wing', 'Right Wing'), (0, 'default2', 'default2', 'Right Wing'), (2, NULL, 'default2', 'default1'), (3, NULL, 'Right Wing', NULL), (4, NULL, NULL, NULL), (5, NULL, NULL, 'default1'), (6, 'default2', 'default1', 'Right Wing');
INSERT INTO player (player_id, club_id, name, position, apps, tries, goals, points) VALUES (1, 6, 'default2', 'Right Wing', 0.0, 0.0, 'default2', 1.0), (0, NULL, 'default1', 'Right Wing', 0.0, 0.0, 'default1', 1.0), (2, 2, 'Right Wing', 'Right Wing', 0.0, 0.0, NULL, 0.0), (3, 1, 'Right Wing', 'Right Wing', 1.0, 1.0, 'default2', 1.0), (4, 2, 'Right Wing', 'default2', 1.0, 1.0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."club_id" AS "club_id", "LHS"."name" AS "name", "LHS"."region" AS "region", "LHS"."start_year" AS "start_year", "RHS"."player_id" AS "player_id", "RHS"."name" AS "name_other", "RHS"."position" AS "position", "RHS"."apps" AS "apps", "RHS"."tries" AS "tries", "RHS"."goals" AS "goals", "RHS"."points" AS "points" FROM "club" AS "LHS" INNER JOIN (SELECT * FROM "player" WHERE ("position" = 'Right Wing')) AS RHS ON (LHS.club_id = RHS.club_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T1.name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID = T2.Club_ID WHERE T2.Position = 'Right Wing';

/*
Prediction Result:
('default2',)
(None,)
('default1',)
*/