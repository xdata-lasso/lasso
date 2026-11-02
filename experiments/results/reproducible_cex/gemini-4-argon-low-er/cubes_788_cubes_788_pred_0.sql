-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "game" ("id", "Season", "Home_team", "Away_team") VALUES (1, 2022, 'Team A', 'Team B');
INSERT INTO "game" ("id", "Season", "Home_team", "Away_team") VALUES (2, 2020, 'Team C', 'Team D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, home_team, away_team FROM game ORDER BY season, game.id NULLS LAST;

/*
Gold Result:
(2020, 'Team C', 'Team D')
(2022, 'Team A', 'Team B')
*/

-- Prediction Query
SELECT season, home_team, away_team FROM game;

/*
Prediction Result:
(2022, 'Team A', 'Team B')
(2020, 'Team C', 'Team D')
*/