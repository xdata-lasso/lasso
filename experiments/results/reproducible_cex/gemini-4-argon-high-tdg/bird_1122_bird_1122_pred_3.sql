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
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (1, 1001, 'Zlatan', 2001, '1981-10-03', 195, 209);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (2, 1002, 'Messi', 2002, '1987-06-24', 170, 159);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (3, 1003, 'Ronaldo', 2003, '1985-02-05', 185, 176);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (4, 1004, 'Bale', 2004, '1989-07-16', 183, 163);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (5, 1005, 'Aguero', 2005, '1988-06-02', 173, 163);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (6, 1006, 'Neymar', 2006, '1992-02-05', 175, 150);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (7, 1007, 'Suarez', 2007, '1987-01-24', 182, 190);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (8, 1008, 'Hazard', 2008, '1991-01-07', 173, 163);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (9, 1009, 'Modric', 2009, '1985-09-09', 174, 143);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (10, 1010, 'Kroos', 2010, '1990-01-04', 182, 172);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (11, 1011, 'Iniesta', 2011, '1984-05-11', 171, 150);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (12, 1012, 'Xavi', 2012, '1980-01-25', 170, 149);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (13, 1013, 'Unmatched_Player', 2013, '1990-01-01', 180, 170);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (1, 2001, 1001, '2015-01-01', 75, 99);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (2, 2002, 1002, '2015-01-01', 94, 95);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (3, 2002, 1002, '2016-01-01', 94, 95);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (4, 2003, 1003, '2015-01-01', 93, 93);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (5, 2003, 1003, '2016-01-01', 93, 93);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (6, 2004, 1004, '2015-01-01', 88, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (7, 2005, 1005, '2015-01-01', 88, 89);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (8, 2006, 1006, '2015-01-01', 90, 94);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (9, 2007, 1007, '2015-01-01', 90, 91);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (10, 2008, 1008, '2015-01-01', 86, 88);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (11, 2009, 1009, '2015-01-01', 85, 85);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (12, 2010, 1010, '2015-01-01', 84, 87);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (13, 2011, 1011, '2015-01-01', 84, 84);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (14, 2012, 1012, '2015-01-01', 80, 98);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, date, overall_rating, potential) VALUES (15, NULL, 9999, '2015-01-01', 99, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id ORDER BY t2.overall_rating DESC, t1.player_name NULLS LAST LIMIT 10;

/*
Gold Result:
('Messi',)
('Ronaldo',)
('Neymar',)
('Suarez',)
('Aguero',)
('Bale',)
('Hazard',)
('Modric',)
('Iniesta',)
('Kroos',)
*/

-- Prediction Query
SELECT T2.player_name FROM Player_Attributes AS T1 INNER JOIN Player AS T2 ON T1.player_fifa_api_id = T2.player_fifa_api_id ORDER BY T1.overall_rating DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('Messi',)
('Messi',)
('Ronaldo',)
('Ronaldo',)
('Neymar',)
('Suarez',)
('Bale',)
('Aguero',)
('Hazard',)
('Modric',)
*/