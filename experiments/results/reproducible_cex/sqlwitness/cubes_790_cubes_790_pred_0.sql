-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, home_games, average_attendance, total_attendance, capacity_percentage) VALUES (0, 'default2', 0, 1.0, NULL, 0.0), (1, NULL, 1, 1.0, NULL, 1.0);
INSERT INTO game (id, stadium_id, season, date, home_team, away_team, score, competition) VALUES (1, 1, 1, NULL, 'default2', 'default2', 'default1', 'default2'), (0, 0, NULL, 'default2', NULL, 'default2', 'default1', 'default2'), (2, 1, NULL, 'default1', 'default1', 'default2', NULL, 'default2'), (3, NULL, 1, 'default1', 'default2', 'default1', NULL, NULL), (4, 0, 1, NULL, NULL, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM game ORDER BY date, game.id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Date FROM game ORDER BY home_team DESC, game.id NULLS LAST;

/*
Prediction Result:
(None,)
('default1',)
('default1',)
('default2',)
(None,)
*/