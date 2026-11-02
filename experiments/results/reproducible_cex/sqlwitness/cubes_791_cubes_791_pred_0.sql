-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, home_games, average_attendance, total_attendance, capacity_percentage) VALUES (1, 'Walter Samuel', NULL, 1.0, 1.0, 0.0), (0, 'default2', NULL, 0.0, 0.0, 0.0), (2, NULL, 0, 0.0, 0.0, 1.0), (3, 'default2', 1, 0.0, NULL, 1.0), (4, 'Walter Samuel', NULL, NULL, 0.0, NULL), (5, 'default2', 0, NULL, NULL, 0.0), (6, 'default1', 1, 1.0, NULL, 1.0);
INSERT INTO game (id, stadium_id, season, date, home_team, away_team, score, competition) VALUES (0, 5, NULL, 'Walter Samuel', 'default1', 'default2', 'default1', 'default1'), (1, NULL, 1, NULL, 'default1', 'default1', 'default1', NULL), (2, 2, NULL, 'Walter Samuel', NULL, 'default2', 'Walter Samuel', 'Walter Samuel'), (3, 6, NULL, NULL, NULL, 'default1', 'Walter Samuel', 'default1'), (4, 4, 1, 'default2', 'Walter Samuel', 'default2', NULL, 'Walter Samuel'), (5, 6, 1, 'Walter Samuel', NULL, 'default1', NULL, NULL), (6, 6, 0, NULL, NULL, 'Walter Samuel', 'default2', 'default2'), (7, 0, 0, 'Walter Samuel', NULL, 'Walter Samuel', 'default2', 'default2'), (8, 6, 1, 'default2', 'Walter Samuel', NULL, 'default2', NULL), (9, 3, NULL, 'default1', NULL, 'default1', 'default1', 'default1'), (10, NULL, 0, NULL, 'default1', 'default1', 'Walter Samuel', 'default1'), (11, 4, NULL, NULL, 'default2', 'default2', 'default2', 'Walter Samuel');
INSERT INTO injury_accident (id, game_id, player, injury, number_of_matches, source) VALUES (0, 5, NULL, 'Walter Samuel', 'default1', NULL), (1, 11, NULL, 'default2', 'default2', 'default2'), (2, 1, NULL, 'default2', 'Walter Samuel', 'default1'), (3, 5, 'default2', 'default1', 'Walter Samuel', 'default1'), (4, 10, 'default1', 'Walter Samuel', 'Walter Samuel', 'Walter Samuel'), (5, 8, 'Walter Samuel', 'default1', 'Walter Samuel', NULL), (6, 7, 'Walter Samuel', 'Walter Samuel', 'default1', NULL), (7, 9, 'default2', 'default2', 'default2', 'default1'), (8, 0, 'Walter Samuel', 'default1', 'default1', 'Walter Samuel'), (9, 1, 'Walter Samuel', 'default2', 'default1', 'default1'), (10, 0, 'default2', 'default1', NULL, 'Walter Samuel'), (11, 11, NULL, 'default2', 'default1', 'Walter Samuel'), (12, 5, 'Walter Samuel', 'Walter Samuel', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "season" FROM (SELECT "stadium_id", "id", "season", "date", "home_team", "away_team", "score", "competition", "id_other", "player", "injury", "number_of_matches", "source", "id" AS "game_id" FROM (SELECT "LHS"."stadium_id" AS "stadium_id", "LHS"."id" AS "id", "LHS"."season" AS "season", "LHS"."date" AS "date", "LHS"."home_team" AS "home_team", "LHS"."away_team" AS "away_team", "LHS"."score" AS "score", "LHS"."competition" AS "competition", "RHS"."id" AS "id_other", "RHS"."player" AS "player", "RHS"."injury" AS "injury", "RHS"."number_of_matches" AS "number_of_matches", "RHS"."source" AS "source" FROM "game" AS "LHS" INNER JOIN "injury_accident" AS "RHS" ON ("LHS"."id" = "RHS"."game_id"))) WHERE ("player" = 'Walter Samuel') ORDER BY season, "season" NULLS LAST;

/*
Gold Result:
(None,)
(0,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT T1.season FROM game AS T1 JOIN injury_accident AS T2 ON T1.id = T2.game_id WHERE T2.player = 'Walter Samuel';

/*
Prediction Result:
(1,)
(0,)
(None,)
(1,)
(1,)
*/