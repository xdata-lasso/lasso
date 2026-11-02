-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, home_games, average_attendance, total_attendance, capacity_percentage) VALUES (1, 'default2', 0, 1.0, 0.0, 1.0), (0, 'default1', 1, 1.0, 1.0, NULL);
INSERT INTO game (id, stadium_id, season, date, home_team, away_team, score, competition) VALUES (1, NULL, 1, 'default2', 'Knee problem', NULL, 'default1', 'Knee problem'), (0, NULL, 1, 'default1', 'Knee problem', 'default1', 'Knee problem', 'default2'), (2, NULL, NULL, NULL, 'default1', 'Knee problem', NULL, 'Knee problem'), (3, NULL, 1, 'default1', 'Knee problem', 'default2', NULL, 'default2');
INSERT INTO injury_accident (id, game_id, player, injury, number_of_matches, source) VALUES (0, 2, 'Knee problem', 'default1', 'default2', 'default1'), (1, 3, 'default2', 'default1', 'default2', 'Knee problem'), (2, 1, NULL, 'default2', 'default2', 'Knee problem'), (3, 3, NULL, 'default2', 'Knee problem', 'Knee problem'), (4, NULL, NULL, 'default1', 'Knee problem', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player", "number_of_matches", "source" FROM "injury_accident" WHERE ("injury" <> 'Knee problem') ORDER BY player, injury_accident.id NULLS LAST;

/*
Gold Result:
(None, 'default2', 'Knee problem')
(None, 'Knee problem', 'Knee problem')
(None, 'Knee problem', 'default2')
('Knee problem', 'default2', 'default1')
('default2', 'default2', 'Knee problem')
*/

-- Prediction Query
SELECT player, number_of_matches, SOURCE FROM injury_accident WHERE injury <> 'Knee problem';

/*
Prediction Result:
('Knee problem', 'default2', 'default1')
('default2', 'default2', 'Knee problem')
(None, 'default2', 'Knee problem')
(None, 'Knee problem', 'Knee problem')
(None, 'Knee problem', 'default2')
*/