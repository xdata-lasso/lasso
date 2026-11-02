-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1030, 'Daniel Gallagher', 1031, 1032.5, 1033.5, 1034.5);
INSERT INTO "stadium" ("id", "name", "home_games", "average_attendance", "total_attendance", "capacity_percentage") VALUES (1037, 'Lindsey Roman', 1038, 1039.5, 1040.5, 1041.5);
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1035, 1030, 1036, 'blue', NULL, 'husband', 'bill', 'her');
INSERT INTO "game" ("id", "stadium_id", "season", "date", "home_team", "away_team", "score", "competition") VALUES (1042, 1037, 1043, 'show', 'machine', 'not', 'capital', 'win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM game ORDER BY date, game.id NULLS LAST;

/*
Gold Result:
('blue',)
('show',)
*/

-- Prediction Query
SELECT Date FROM game ORDER BY home_team DESC, game.id NULLS LAST;

/*
Prediction Result:
('show',)
('blue',)
*/