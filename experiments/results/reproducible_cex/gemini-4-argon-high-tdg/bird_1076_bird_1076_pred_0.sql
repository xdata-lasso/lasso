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
-- DATASET 1
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (1, 101, 'Abdou Diallo', 1001, '1996-05-04', 186, 174);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (2, 102, 'Aaron Appindangoye', 1002, '1992-02-20', 184, 185);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (3, 103, 'Lionel Messi', 1003, '1987-06-24', 170, 159);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, crossing, finishing, heading_accuracy, short_passing, dribbling, long_passing, ball_control) VALUES (10, 1001, 101, '2015-01-01', 70, 80, 45, 35, 72, 65, 50, 62, 60);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, crossing, finishing, heading_accuracy, short_passing, dribbling, long_passing, ball_control) VALUES (11, 1001, 101, '2015-06-01', 72, 80, 46, 36, 73, 66, 52, 63, 60);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, crossing, finishing, heading_accuracy, short_passing, dribbling, long_passing, ball_control) VALUES (12, 1001, 101, '2016-01-01', 74, 81, 48, 38, 75, 68, 55, 65, 64);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, crossing, finishing, heading_accuracy, short_passing, dribbling, long_passing, ball_control) VALUES (20, 1002, 102, '2015-01-01', 65, 70, 40, 30, 68, 55, 40, 50, 50);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, crossing, finishing, heading_accuracy, short_passing, dribbling, long_passing, ball_control) VALUES (21, 1002, 102, '2016-01-01', 67, 72, 42, 32, 70, 58, 42, 53, 55);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, crossing, finishing, heading_accuracy, short_passing, dribbling, long_passing, ball_control) VALUES (30, 1003, 103, '2016-01-01', 94, 95, 80, 95, 71, 92, 97, 86, 96);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN t1.player_name = 'Abdou Diallo' THEN t2.ball_control ELSE 0 END) AS REAL) / COUNT(CASE WHEN t1.player_name = 'Abdou Diallo' THEN t2.id ELSE NULL END) - CAST(SUM(CASE WHEN t1.player_name = 'Aaron Appindangoye' THEN t2.ball_control ELSE 0 END) AS REAL) / COUNT(CASE WHEN t1.player_name = 'Aaron Appindangoye' THEN t2.id ELSE NULL END) FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id;

/*
Gold Result:
(8.833333333333336,)
*/

-- Prediction Query
SELECT (SELECT AVG(ball_control) FROM Player_Attributes WHERE player_api_id = (SELECT player_api_id FROM Player WHERE player_name = 'Abdou Diallo')) - (SELECT AVG(ball_control) FROM Player_Attributes WHERE player_api_id = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Appindangoye')) AS difference FROM Player_Attributes;

/*
Prediction Result:
(8.833333333333336,)
(8.833333333333336,)
(8.833333333333336,)
(8.833333333333336,)
(8.833333333333336,)
(8.833333333333336,)
*/