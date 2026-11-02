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
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (1, 101, 'Player_B', 1001, '1990-01-01', 181, 175);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (2, 102, 'Player_A', 1002, '1990-01-02', 185, 180);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (3, 103, 'Player_C', 1003, '1990-01-03', 182, 170);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (4, 104, 'Player_D', 1004, '1990-01-04', 183, 172);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (5, 105, 'Player_E', 1005, '1990-01-05', 184, 174);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (6, 106, 'Player_F', 1006, '1990-01-06', 186, 176);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (7, 107, 'Player_G', 1007, '1990-01-07', 187, 178);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (8, 108, 'Player_H', 1008, '1990-01-08', 188, 180);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (9, 109, 'Player_I', 1009, '1990-01-09', 189, 182);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (10, 110, 'Player_J', 1010, '1990-01-10', 190, 184);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (11, 111, 'Player_K', 1011, '1990-01-11', 191, 186);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (12, 112, 'Player_L', 1012, '1990-01-12', 192, 188);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (13, 113, 'Boundary_180', 1013, '1990-01-13', 180, 190);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (14, 114, 'Short_Heavy', 1014, '1990-01-14', 175, 195);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (15, 115, 'Null_Height', 1015, '1990-01-15', NULL, 190);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (16, 116, 'No_Attributes', 1016, '1990-01-16', 195, 190);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (1, 1001, 101, 85, 70);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (2, 1001, 101, 86, 70);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (3, 1002, 102, 85, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (4, 1002, 102, 85, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (5, 1002, 102, 86, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (6, 1003, 103, 80, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (7, 1004, 104, 79, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (8, 1005, 105, 78, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (9, 1006, 106, 77, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (10, 1007, 107, 76, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (11, 1008, 108, 75, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (12, 1009, 109, 74, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (13, 1010, 110, 73, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (14, 1011, 111, 72, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (15, 1012, 112, 71, 75);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (16, 1013, 113, 99, 99);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (17, 1014, 114, 99, 99);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, heading_accuracy, overall_rating) VALUES (18, 1015, 115, 99, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id WHERE t1.height > 180 GROUP BY t1.id ORDER BY CAST(SUM(t2.heading_accuracy) AS REAL) / COUNT(t2."player_fifa_api_id") DESC, t1.player_name NULLS LAST LIMIT 10;

/*
Gold Result:
('Player_B',)
('Player_A',)
('Player_C',)
('Player_D',)
('Player_E',)
('Player_F',)
('Player_G',)
('Player_H',)
('Player_I',)
('Player_J',)
*/

-- Prediction Query
SELECT T1.player_name FROM Player AS T1 INNER JOIN Player_Attributes AS T2 ON T1.player_fifa_api_id = T2.player_fifa_api_id WHERE T1.height > 180 GROUP BY T1.player_name ORDER BY SUM(T2.heading_accuracy) / COUNT(T2.player_fifa_api_id) DESC, T1.player_name NULLS LAST LIMIT 10;

/*
Prediction Result:
('Player_A',)
('Player_B',)
('Player_C',)
('Player_D',)
('Player_E',)
('Player_F',)
('Player_G',)
('Player_H',)
('Player_I',)
('Player_J',)
*/