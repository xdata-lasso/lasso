-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1049, 'Patricia Galloway', 1050, 1051.5, 1052.5, 1053.5);
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1065, 'Carla Gray', 1066, 1067.5, 1068.5, 1069.5);
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1054, 1049, 1055, 'top', 'early', 'trial', 'blood', 'husband');
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1070, 1065, 1071, 'wish', 'push', 'rise', 'onto', 'discuss');
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (1056, 1054, 'fall', 'long', 'prove', 'they');
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (1064, 1054, 'away', 'politics', 'Congress', 'none');
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (1072, 1070, 'reveal', 'garden', 'threat', 'special');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, player FROM (SELECT LHS.stadium_id AS stadium_id, LHS.id AS id, LHS.season AS season, LHS.date AS date, LHS.home_team AS home_team, LHS.away_team AS away_team, LHS.score AS score, LHS.competition AS competition, RHS.id AS id_other, RHS.player AS player, RHS.injury AS injury, RHS.number_of_matches AS number_of_matches, RHS.source AS SOURCE FROM game AS LHS INNER JOIN injury_accident AS RHS ON (LHS.id = RHS.game_id)) ORDER BY date, player NULLS LAST;

/*
Gold Result:
('top', 'away')
('top', 'fall')
('wish', 'reveal')
*/

-- Prediction Query
SELECT T1.date, T2.player FROM game AS T1 JOIN injury_accident AS T2 ON T1.id = T2.game_id ORDER BY T1.season DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Prediction Result:
('wish', 'reveal')
('top', 'fall')
('top', 'away')
*/