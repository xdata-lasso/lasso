-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, home_games, average_attendance, total_attendance, capacity_percentage) VALUES (0, 'default2', 1, 1.0, 0.0, 0.0), (1, 'default1', 0, 1.0, 1.0, 0.0), (2, 'default2', 1, 0.0, 0.0, NULL), (3, NULL, 1, 1.0, NULL, NULL), (4, 'default1', 1, 0.0, 1.0, 1.0), (5, NULL, NULL, NULL, 1.0, 1.0), (6, 'default1', 0, 1.0, 0.0, 1.0), (7, NULL, 0, NULL, NULL, 1.0);
INSERT INTO game (id, stadium_id, season, date, home_team, away_team, score, competition) VALUES (1, 6, 1, NULL, 'default2', 'default2', 'default2', 'default2'), (0, 4, 0, 'default1', 'default2', 'default2', NULL, NULL), (2, 1, NULL, 'default2', 'default1', NULL, NULL, 'default2'), (3, 7, 0, 'default1', 'default2', NULL, NULL, 'default1'), (4, 3, 0, 'default2', 'default1', 'default2', 'default2', 'default1');
INSERT INTO injury_accident (id, game_id, player, injury, number_of_matches, source) VALUES (0, 3, 'default2', 'default1', 'default1', NULL), (1, 2, NULL, 'default2', 'default1', 'default1'), (2, 0, 'default2', 'default1', 'default2', NULL), (3, 0, NULL, 'default2', NULL, NULL), (4, NULL, 'default2', 'default1', 'default1', 'default1'), (5, 0, NULL, NULL, 'default1', 'default1'), (6, 4, 'default1', 'default1', NULL, 'default1'), (7, NULL, NULL, 'default1', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, player FROM (SELECT LHS.stadium_id AS stadium_id, LHS.id AS id, LHS.season AS season, LHS.date AS date, LHS.home_team AS home_team, LHS.away_team AS away_team, LHS.score AS score, LHS.competition AS competition, RHS.id AS id_other, RHS.player AS player, RHS.injury AS injury, RHS.number_of_matches AS number_of_matches, RHS.source AS SOURCE FROM game AS LHS INNER JOIN injury_accident AS RHS ON (LHS.id = RHS.game_id)) ORDER BY date, player NULLS LAST;

/*
Gold Result:
('default1', 'default2')
('default1', 'default2')
('default1', None)
('default1', None)
('default2', 'default1')
('default2', None)
*/

-- Prediction Query
SELECT T1.date, T2.player FROM game AS T1 JOIN injury_accident AS T2 ON T1.id = T2.game_id ORDER BY T1.season DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Prediction Result:
('default1', 'default2')
('default1', None)
('default1', None)
('default1', 'default2')
('default2', 'default1')
('default2', None)
*/