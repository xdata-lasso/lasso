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
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (1, 101, 'Zlatan', 1001, '1981-10-03', 195, 209);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (2, 102, 'Messi', 1002, '1987-06-24', 170, 159);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (3, 103, 'Ronaldo', 1003, '1985-02-05', 185, 176);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (4, 104, 'Pirlo', 1004, '1979-05-19', 177, 150);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (5, 105, 'Lampard', 1005, '1978-06-20', 184, 196);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (6, 106, 'Gerrard', 1006, '1980-05-30', 183, 183);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (7, 107, 'Xavi', 1007, '1980-01-25', 170, 150);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (8, 108, 'Iniesta', 1008, '1984-05-11', 171, 150);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (9, 109, 'Rooney', 1009, '1985-10-24', 176, 183);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (10, 112, 'Zidane', 1010, '1972-06-23', 185, 176);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (11, 111, 'Henry', 1011, '1977-08-17', 188, 183);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (12, 110, 'Bergkamp', 1012, '1969-05-10', 183, 172);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (1, 1012, 111, '2015-01-01', 70, 72, 60, 50, 65, 96);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (2, 1011, 112, '2015-01-01', 72, 74, 62, 55, 68, 92);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (3, 1010, 109, '2015-01-01', 94, 95, 95, 90, 94, 88);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (4, 1009, 108, '2015-01-01', 75, 76, 65, 93, 70, 88);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (5, 1008, 107, '2015-01-01', 78, 80, 70, 72, 85, 85);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (6, 1007, 106, '2015-01-01', 80, 81, 75, 78, 88, 82);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (7, 1006, 105, '2015-01-01', 82, 84, 77, 80, 72, 79);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (8, 1005, 104, '2015-01-01', 85, 86, 80, 82, 75, 76);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (9, 1004, 103, '2015-01-01', 88, 89, 85, 84, 80, 74);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (10, 1003, 102, '2015-01-01', 90, 91, 88, 86, 82, 70);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (11, 1002, 101, '2015-01-01', 92, 93, 90, 88, 86, 70);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential, finishing, free_kick_accuracy, shot_power, penalties) VALUES (12, 1001, 110, '2015-01-01', 95, 96, 92, 91, 90, 65);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t2.player_name FROM Player_Attributes AS t1 INNER JOIN Player AS t2 ON t1.id = t2.id ORDER BY t1.penalties DESC, t1.id NULLS LAST, t2.id NULLS LAST LIMIT 10;

/*
Gold Result:
('Zlatan',)
('Messi',)
('Ronaldo',)
('Pirlo',)
('Lampard',)
('Gerrard',)
('Xavi',)
('Iniesta',)
('Rooney',)
('Zidane',)
*/

-- Prediction Query
SELECT P.player_name FROM Player AS P INNER JOIN Player_Attributes AS PA ON P.player_api_id = PA.player_api_id ORDER BY PA.penalties DESC, P.id NULLS LAST, PA.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('Henry',)
('Zidane',)
('Iniesta',)
('Rooney',)
('Xavi',)
('Gerrard',)
('Lampard',)
('Pirlo',)
('Ronaldo',)
('Zlatan',)
*/