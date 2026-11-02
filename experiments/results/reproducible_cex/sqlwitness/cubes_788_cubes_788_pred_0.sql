-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, home_games, average_attendance, total_attendance, capacity_percentage) VALUES (0, NULL, 0, NULL, NULL, 0.0);
INSERT INTO game (id, stadium_id, season, date, home_team, away_team, score, competition) VALUES (1, 0, NULL, 'default1', NULL, NULL, NULL, 'default1'), (0, NULL, 0, 'default1', 'default1', 'default1', 'default2', NULL), (2, 0, NULL, NULL, 'default1', 'default1', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, home_team, away_team FROM game ORDER BY season, game.id NULLS LAST;

/*
Gold Result:
(None, None, None)
(None, 'default1', 'default1')
(0, 'default1', 'default1')
*/

-- Prediction Query
SELECT season, home_team, away_team FROM game;

/*
Prediction Result:
(0, 'default1', 'default1')
(None, None, None)
(None, 'default1', 'default1')
*/