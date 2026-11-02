-- Schema DDL
CREATE TABLE IF NOT EXISTS "Player_Attributes" ("id" INTEGER PRIMARY KEY, "player_fifa_api_id" INTEGER, "player_api_id" INTEGER, "date" TEXT(255), "overall_rating" INTEGER, "potential" INTEGER, "preferred_foot" TEXT(255), "attacking_work_rate" TEXT(255), "defensive_work_rate" TEXT(255), "crossing" INTEGER, "finishing" INTEGER, "heading_accuracy" INTEGER, "short_passing" INTEGER, "volleys" INTEGER, "dribbling" INTEGER, "curve" INTEGER, "free_kick_accuracy" INTEGER, "long_passing" INTEGER, "ball_control" INTEGER, "acceleration" INTEGER, "sprint_speed" INTEGER, "agility" INTEGER, "reactions" INTEGER, "balance" INTEGER, "shot_power" INTEGER, "jumping" INTEGER, "stamina" INTEGER, "strength" INTEGER, "long_shots" INTEGER, "aggression" INTEGER, "interceptions" INTEGER, "positioning" INTEGER, "vision" INTEGER, "penalties" INTEGER, "marking" INTEGER, "standing_tackle" INTEGER, "sliding_tackle" INTEGER, "gk_diving" INTEGER, "gk_handling" INTEGER, "gk_kicking" INTEGER, "gk_positioning" INTEGER, "gk_reflexes" INTEGER, FOREIGN KEY (player_fifa_api_id) REFERENCES Player (player_fifa_api_id));

CREATE TABLE IF NOT EXISTS "Player" ("id" INTEGER PRIMARY KEY, "player_api_id" INTEGER, "player_name" TEXT(255), "player_fifa_api_id" INTEGER UNIQUE, "birthday" TEXT(255), "height" INTEGER, "weight" INTEGER);

CREATE TABLE IF NOT EXISTS "League" ("id" INTEGER PRIMARY KEY, "country_id" INTEGER, "name" TEXT(255), FOREIGN KEY (country_id) REFERENCES Country (id));

CREATE TABLE IF NOT EXISTS "Country" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE IF NOT EXISTS "Team" ("id" INTEGER PRIMARY KEY, "team_api_id" INTEGER UNIQUE, "team_fifa_api_id" INTEGER UNIQUE, "team_long_name" TEXT(255), "team_short_name" TEXT(255));

CREATE TABLE IF NOT EXISTS "Team_Attributes" ("id" INTEGER PRIMARY KEY, "team_fifa_api_id" INTEGER, "team_api_id" INTEGER, "date" TEXT(255), "buildUpPlaySpeed" INTEGER, "buildUpPlaySpeedClass" TEXT(255), "buildUpPlayDribbling" INTEGER, "buildUpPlayDribblingClass" TEXT(255), "buildUpPlayPassing" INTEGER, "buildUpPlayPassingClass" TEXT(255), "buildUpPlayPositioningClass" TEXT(255), "chanceCreationPassing" INTEGER, "chanceCreationPassingClass" TEXT(255), "chanceCreationCrossing" INTEGER, "chanceCreationCrossingClass" TEXT(255), "chanceCreationShooting" INTEGER, "chanceCreationShootingClass" TEXT(255), "chanceCreationPositioningClass" TEXT(255), "defencePressure" INTEGER, "defencePressureClass" TEXT(255), "defenceAggression" INTEGER, "defenceAggressionClass" TEXT(255), "defenceTeamWidth" INTEGER, "defenceTeamWidthClass" TEXT(255), "defenceDefenderLineClass" TEXT(255), FOREIGN KEY (team_fifa_api_id) REFERENCES Team (team_fifa_api_id));

CREATE TABLE IF NOT EXISTS "Match" ("id" INTEGER PRIMARY KEY, "country_id" INTEGER, "league_id" INTEGER, "season" TEXT(255), "stage" INTEGER, "date" TEXT(255), "match_api_id" INTEGER, "home_team_api_id" INTEGER, "away_team_api_id" INTEGER, "home_team_goal" INTEGER, "away_team_goal" INTEGER, "home_player_X1" INTEGER, "home_player_X2" INTEGER, "home_player_X3" INTEGER, "home_player_X4" INTEGER, "home_player_X5" INTEGER, "home_player_X6" INTEGER, "home_player_X7" INTEGER, "home_player_X8" INTEGER, "home_player_X9" INTEGER, "home_player_X10" INTEGER, "home_player_X11" INTEGER, "away_player_X1" INTEGER, "away_player_X2" INTEGER, "away_player_X3" INTEGER, "away_player_X4" INTEGER, "away_player_X5" INTEGER, "away_player_X6" INTEGER, "away_player_X7" INTEGER, "away_player_X8" INTEGER, "away_player_X9" INTEGER, "away_player_X10" INTEGER, "away_player_X11" INTEGER, "home_player_Y1" INTEGER, "home_player_Y2" INTEGER, "home_player_Y3" INTEGER, "home_player_Y4" INTEGER, "home_player_Y5" INTEGER, "home_player_Y6" INTEGER, "home_player_Y7" INTEGER, "home_player_Y8" INTEGER, "home_player_Y9" INTEGER, "home_player_Y10" INTEGER, "home_player_Y11" INTEGER, "away_player_Y1" INTEGER, "away_player_Y2" INTEGER, "away_player_Y3" INTEGER, "away_player_Y4" INTEGER, "away_player_Y5" INTEGER, "away_player_Y6" INTEGER, "away_player_Y7" INTEGER, "away_player_Y8" INTEGER, "away_player_Y9" INTEGER, "away_player_Y10" INTEGER, "away_player_Y11" INTEGER, "home_player_1" INTEGER, "home_player_2" INTEGER, "home_player_3" INTEGER, "home_player_4" INTEGER, "home_player_5" INTEGER, "home_player_6" INTEGER, "home_player_7" INTEGER, "home_player_8" INTEGER, "home_player_9" INTEGER, "home_player_10" INTEGER, "home_player_11" INTEGER, "away_player_1" INTEGER, "away_player_2" INTEGER, "away_player_3" INTEGER, "away_player_4" INTEGER, "away_player_5" INTEGER, "away_player_6" INTEGER, "away_player_7" INTEGER, "away_player_8" INTEGER, "away_player_9" INTEGER, "away_player_10" INTEGER, "away_player_11" INTEGER, "goal" TEXT(255), "shoton" TEXT(255), "shotoff" TEXT(255), "foulcommit" TEXT(255), "card" TEXT(255), "cross" TEXT(255), "corner" TEXT(255), "possession" TEXT(255), "B365H" REAL, "B365D" REAL, "B365A" REAL, "BWH" REAL, "BWD" REAL, "BWA" REAL, "IWH" REAL, "IWD" REAL, "IWA" REAL, "LBH" REAL, "LBD" REAL, "LBA" REAL, "PSH" REAL, "PSD" REAL, "PSA" REAL, "WHH" REAL, "WHD" REAL, "WHA" REAL, "SJH" REAL, "SJD" REAL, "SJA" REAL, "VCH" REAL, "VCD" REAL, "VCA" REAL, "GBH" REAL, "GBD" REAL, "GBA" REAL, "BSH" REAL, "BSD" REAL, "BSA" REAL, FOREIGN KEY (home_team_api_id) REFERENCES Team (team_api_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. GROUP BY t1.id vs GROUP BY t1.player_name (distinct players with identical names).
-- 2. JOIN ON player_api_id vs player_fifa_api_id or id (cross-matched foreign keys).
-- 3. COUNT(t2.player_fifa_api_id) vs COUNT(*) vs AVG(t2.heading_accuracy) when NULLs exist.
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, height) VALUES (1, 101, 'Twin_Name', 1001, 185);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, height) VALUES (2, 102, 'Twin_Name', 1002, 185);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, height) VALUES (3, 103, 'Middle_Player', 1003, 185);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, height) VALUES (4, 104, 'Join_Key_Test_A', 1004, 185);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, height) VALUES (5, 105, 'Join_Key_Test_B', 1005, 185);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, height) VALUES (6, 106, 'Null_Fifa_Id_Test', 1006, 185);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, height) VALUES (7, 107, 'Null_Heading_Test', 1007, 185);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, height) VALUES (8, 108, 'Baseline_75', 1008, 185);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (1, 1001, 101, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (2, 1002, 102, 30);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (3, 1003, 103, 85);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (4, 1005, 104, 95);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (5, 1004, 105, 40);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (6, 1006, 106, 40);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (7, NULL, 106, 40);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (8, 1007, 107, 100);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (9, 1007, 107, NULL);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy) VALUES (10, 1008, 108, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.height > 180 GROUP BY t1.id ORDER BY CAST(SUM(t2.heading_accuracy) AS REAL) / COUNT(t2."player_fifa_api_id") DESC, t1.player_name NULLS LAST LIMIT 10;

/*
Gold Result:
('Join_Key_Test_A',)
('Twin_Name',)
('Middle_Player',)
('Null_Fifa_Id_Test',)
('Baseline_75',)
('Null_Heading_Test',)
('Join_Key_Test_B',)
('Twin_Name',)
*/

-- Prediction Query
SELECT P.player_name, AVG(PA.heading_accuracy) AS avg_heading_accuracy FROM Player AS P INNER JOIN Player_Attributes AS PA ON P.player_api_id = PA.player_api_id WHERE P.height > 180 GROUP BY P.player_api_id ORDER BY avg_heading_accuracy DESC, P.player_name NULLS LAST LIMIT 10;

/*
Prediction Result:
('Null_Heading_Test', 100.0)
('Join_Key_Test_A', 95.0)
('Twin_Name', 90.0)
('Middle_Player', 85.0)
('Baseline_75', 75.0)
('Join_Key_Test_B', 40.0)
('Null_Fifa_Id_Test', 40.0)
('Twin_Name', 30.0)
*/