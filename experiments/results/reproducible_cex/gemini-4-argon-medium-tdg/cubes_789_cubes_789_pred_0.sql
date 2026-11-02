-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY date, player NULLS LAST (specifically testing NULL ordering for both columns and tie-breaking).
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'Main Stadium', 10, 5000.0, 50000.0, 95.0);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (101, 1, 2020, '2020-10-10', 'Alpha', 'Beta', '3-1', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (102, 1, 2020, '2020-01-01', 'Gamma', 'Delta', '0-0', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (103, 1, 2020, NULL, 'Epsilon', 'Zeta', '1-2', 'Cup');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (201, 101, 'Zack', 'Knee', '5', 'Official');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (202, 101, NULL, 'Concussion', '2', 'Official');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (203, 101, 'Aaron', 'Shoulder', '4', 'TV');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (204, 102, 'Bob', 'Foot', '1', 'Radio');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (205, 103, 'Charlie', 'Back', '6', 'Paper');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (206, 103, NULL, 'Neck', '8', 'Paper');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, player FROM (SELECT LHS.stadium_id AS stadium_id, LHS.id AS id, LHS.season AS season, LHS.date AS date, LHS.home_team AS home_team, LHS.away_team AS away_team, LHS.score AS score, LHS.competition AS competition, RHS.id AS id_other, RHS.player AS player, RHS.injury AS injury, RHS.number_of_matches AS number_of_matches, RHS.source AS SOURCE FROM game AS LHS INNER JOIN injury_accident AS RHS ON (LHS.id = RHS.game_id)) ORDER BY date, player NULLS LAST;

/*
Gold Result:
(None, 'Charlie')
(None, None)
('2020-01-01', 'Bob')
('2020-10-10', 'Aaron')
('2020-10-10', 'Zack')
('2020-10-10', None)
*/

-- Prediction Query
SELECT T1.date, T2.player FROM game AS T1 JOIN injury_accident AS T2 ON T1.id = T2.game_id ORDER BY T1.season DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Prediction Result:
('2020-10-10', 'Zack')
('2020-10-10', None)
('2020-10-10', 'Aaron')
('2020-01-01', 'Bob')
(None, 'Charlie')
(None, None)
*/