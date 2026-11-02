-- Schema DDL
CREATE TABLE "stadium" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Home_Games" INTEGER, "Average_Attendance" REAL, "Total_Attendance" REAL, "Capacity_Percentage" REAL);

CREATE TABLE "game" ("id" INTEGER PRIMARY KEY, "stadium_id" INTEGER, "Season" INTEGER, "Date" TEXT, "Home_team" TEXT, "Away_team" TEXT, "Score" TEXT, "Competition" TEXT, FOREIGN KEY ("stadium_id") REFERENCES "stadium" ("id"));

CREATE TABLE "injury_accident" ("id" INTEGER PRIMARY KEY, "game_id" INTEGER, "Player" TEXT, "Injury" TEXT, "Number_of_matches" TEXT, "Source" TEXT, FOREIGN KEY ("game_id") REFERENCES "game" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard matching, duplicates in GROUP BY, NULL injury handling (producing 0 and 1), and DISTINCT on the outer query.
INSERT INTO stadium (id, name, Home_Games, Average_Attendance, Total_Attendance, Capacity_Percentage) VALUES (1, 'Alpha Stadium', 10, 5000.0, 50000.0, 80.0);
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (1, 1, 2011, '2011-05-01', 'Team A', 'Team B', '1-0', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (2, 1, 2012, '2012-05-01', 'Team C', 'Team D', '2-2', 'League');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (3, 1, 2013, '2013-05-01', 'Team E', 'Team F', '0-1', 'Cup');
INSERT INTO game (id, stadium_id, Season, Date, Home_team, Away_team, Score, Competition) VALUES (4, 1, 2014, '2014-05-01', 'Team G', 'Team H', '3-1', 'Cup');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (1, 1, 'Player 1', 'Knee', '3', 'Report');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (2, 2, 'Player 2', 'Knee', '5', 'Report');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (3, 3, 'Player 3', 'Ankle', '2', 'News');
INSERT INTO injury_accident (id, game_id, Player, Injury, Number_of_matches, Source) VALUES (4, 4, 'Player 4', NULL, '1', 'News');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_t1_injury_ FROM (SELECT injury, COUNT(DISTINCT injury) AS n_distinct FROM (SELECT * FROM injury_accident AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM game WHERE (season > 2010)) AS RHS WHERE (LHS.id = RHS.id))) GROUP BY injury) ORDER BY count_distinct_t1_injury_;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.injury) FROM injury_accident AS T1 JOIN game AS T2 ON T1.game_id = T2.id WHERE T2.season > 2010;

/*
Prediction Result:
(2,)
*/