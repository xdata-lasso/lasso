-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1043, 'Laura Bush', 1044, 1045.5, 1046.5, 1047.5);
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1051, 'Donald Reid', 1052, 1053.5, 1054.5, 1055.5);
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1048, 1043, 1049, 'answer', 'recently', 'drive', 'spring', 'figure');
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1056, 1051, 1057, 'his', 'commercial', 'hospital', 'hear', 'determine');
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (1050, 1048, 'base', 'top', 'early', 'trial');
INSERT INTO "injury_accident" ("id", "game_id", "player", "injury", "number_of_matches", "source") VALUES (1058, 1056, 'religious', 'example', 'science', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_source_ FROM (SELECT number_of_matches, COUNT(DISTINCT SOURCE) AS n_distinct FROM injury_accident GROUP BY number_of_matches) ORDER BY count_distinct_source_;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT SOURCE) FROM injury_accident;

/*
Prediction Result:
(1,)
*/