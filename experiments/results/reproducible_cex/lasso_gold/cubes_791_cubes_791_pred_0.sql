-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1185, 'Shannon Jones', 1186, 1187.5, 1188.5, 1189.5);
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1193, 'Laura Kennedy', 1194, 1195.5, 1196.5, 1197.5);
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1190, 1185, 1192, 'economy', 'family', 'relationship', 'investment', 'customer');
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1198, 1193, 1191, 'still', 'material', 'surface', 'mention', 'difficult');
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (1192, 1190, 'Walter Samuel', 'notice', 'cause', 'several');
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (1200, 1198, 'Walter Samuel', 'between', 'bill', 'reason');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "season" FROM (SELECT "stadium_id", "id", "season", "date", "home_team", "away_team", "score", "competition", "id_other", "player", "injury", "number_of_matches", "source", "id" AS "game_id" FROM (SELECT "LHS"."stadium_id" AS "stadium_id", "LHS"."id" AS "id", "LHS"."season" AS "season", "LHS"."date" AS "date", "LHS"."home_team" AS "home_team", "LHS"."away_team" AS "away_team", "LHS"."score" AS "score", "LHS"."competition" AS "competition", "RHS"."id" AS "id_other", "RHS"."player" AS "player", "RHS"."injury" AS "injury", "RHS"."number_of_matches" AS "number_of_matches", "RHS"."source" AS "source" FROM "game" AS "LHS" INNER JOIN "injury_accident" AS "RHS" ON ("LHS"."id" = "RHS"."game_id"))) WHERE ("player" = 'Walter Samuel') ORDER BY season, "season" NULLS LAST;

/*
Gold Result:
(1191,)
(1192,)
*/

-- Prediction Query
SELECT T1.season FROM game AS T1 JOIN injury_accident AS T2 ON T1.id = T2.game_id WHERE T2.player = 'Walter Samuel';

/*
Prediction Result:
(1192,)
(1191,)
*/