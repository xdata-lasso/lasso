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
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (1, 101, 201, 'Alpha FC', 'ALP');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (2, 102, 202, 'Beta FC', 'BET');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (3, 103, 203, 'Gamma FC', 'GAM');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (4, 104, 204, 'Delta FC', 'DEL');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (5, 105, 205, 'Epsilon FC', 'EPS');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (6, 106, 206, 'Zeta FC', 'ZET');
INSERT INTO Team_Attributes (id, team_fifa_api_id, team_api_id, date, buildUpPlaySpeed, buildUpPlayDribbling, buildUpPlayPassing, chanceCreationPassing, chanceCreationCrossing, chanceCreationShooting, defencePressure, defenceAggression, defenceTeamWidth) VALUES (1, 201, 101, '2015-01-01', 50, 30, 40, 45, 55, 60, 35, 65, 70);
INSERT INTO Team_Attributes (id, team_fifa_api_id, team_api_id, date, buildUpPlaySpeed, buildUpPlayDribbling, buildUpPlayPassing, chanceCreationPassing, chanceCreationCrossing, chanceCreationShooting, defencePressure, defenceAggression, defenceTeamWidth) VALUES (2, 202, 102, '2015-01-01', 60, 10, 42, 46, 56, 61, 36, 66, 71);
INSERT INTO Team_Attributes (id, team_fifa_api_id, team_api_id, date, buildUpPlaySpeed, buildUpPlayDribbling, buildUpPlayPassing, chanceCreationPassing, chanceCreationCrossing, chanceCreationShooting, defencePressure, defenceAggression, defenceTeamWidth) VALUES (3, 203, 103, '2015-01-01', 70, 50, 43, 47, 57, 62, 37, 67, 72);
INSERT INTO Team_Attributes (id, team_fifa_api_id, team_api_id, date, buildUpPlaySpeed, buildUpPlayDribbling, buildUpPlayPassing, chanceCreationPassing, chanceCreationCrossing, chanceCreationShooting, defencePressure, defenceAggression, defenceTeamWidth) VALUES (4, 204, 104, '2015-01-01', 80, 20, 44, 48, 58, 63, 38, 68, 73);
INSERT INTO Team_Attributes (id, team_fifa_api_id, team_api_id, date, buildUpPlaySpeed, buildUpPlayDribbling, buildUpPlayPassing, chanceCreationPassing, chanceCreationCrossing, chanceCreationShooting, defencePressure, defenceAggression, defenceTeamWidth) VALUES (5, 205, 105, '2015-01-01', 90, 40, 45, 49, 59, 64, 39, 69, 74);
INSERT INTO Team_Attributes (id, team_fifa_api_id, team_api_id, date, buildUpPlaySpeed, buildUpPlayDribbling, buildUpPlayPassing, chanceCreationPassing, chanceCreationCrossing, chanceCreationShooting, defencePressure, defenceAggression, defenceTeamWidth) VALUES (6, 206, 106, '2015-01-01', 95, 60, 46, 50, 60, 65, 40, 70, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t1.buildUpPlaySpeed FROM Team_Attributes AS t1 INNER JOIN Team AS t2 ON t1.team_api_id = t2.team_api_id ORDER BY t1.buildUpPlayDribbling ASC, t1.id NULLS LAST, t2.id NULLS LAST LIMIT 4;

/*
Gold Result:
(60,)
(80,)
(50,)
(90,)
*/

-- Prediction Query
SELECT T2.buildUpPlaySpeed FROM Team AS T1 INNER JOIN Team_Attributes AS T2 ON T1.team_api_id = T2.team_api_id WHERE NOT T2.buildUpPlaySpeed IS NULL ORDER BY T2.buildUpPlaySpeed DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 4;

/*
Prediction Result:
(95,)
(90,)
(80,)
(70,)
*/