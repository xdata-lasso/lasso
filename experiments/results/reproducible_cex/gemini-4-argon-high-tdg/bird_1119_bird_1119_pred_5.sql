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
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (1, 100, 1000, 'Tottenham Hotspur', 'TOT');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (2, 200, 2000, 'Arsenal', 'ARS');
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (10, 500, 'Aaron Lennon', 5000, '1987-04-16', 165, 139);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (500, 600, 'Gareth Bale', 6000, '1989-07-16', 183, 163);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (20, 5000, 'Aaron Ramsey', 500, '1990-12-26', 178, 168);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id, birthday, height, weight) VALUES (30, 700, 'Neil Lennon', 7000, '1971-06-25', 173, 154);
INSERT INTO Match (id, country_id, league_id, season, stage, date, match_api_id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9, home_player_9, away_player_8, away_player_10, away_player_X9, away_player_Y9) VALUES (1, 1, 1, '2010/2011', 1, '2010-08-14', 1001, 100, 200, 2, 1, 500, 600, 600, 600, 600, 600);
INSERT INTO Match (id, country_id, league_id, season, stage, date, match_api_id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9, home_player_9, away_player_8, away_player_10, away_player_X9, away_player_Y9) VALUES (2, 1, 1, '2010/2011', 2, '2010-08-21', 1002, 100, 200, 2, 4, 500, 700, 700, 700, 700, 700);
INSERT INTO Match (id, country_id, league_id, season, stage, date, match_api_id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9, home_player_9, away_player_8, away_player_10, away_player_X9, away_player_Y9) VALUES (3, 1, 1, '2010/2011', 3, '2010-08-28', 1003, 100, 200, 5, 0, 500, 700, 700, 700, 700, 700);
INSERT INTO Match (id, country_id, league_id, season, stage, date, match_api_id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9, home_player_9, away_player_8, away_player_10, away_player_X9, away_player_Y9) VALUES (4, 1, 1, '2010/2011', 4, '2010-09-11', 1004, 100, 200, 10, 3, 10, 500, 500, 500, 500, 500);
INSERT INTO Match (id, country_id, league_id, season, stage, date, match_api_id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9, home_player_9, away_player_8, away_player_10, away_player_X9, away_player_Y9) VALUES (5, 1, 1, '2010/2011', 5, '2010-09-18', 1005, 100, 200, 20, 7, 5000, 10, 10, 10, 10, 10);
INSERT INTO Match (id, country_id, league_id, season, stage, date, match_api_id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9, home_player_9, away_player_8, away_player_10, away_player_X9, away_player_Y9) VALUES (6, 1, 1, '2010/2011', 6, '2010-09-25', 1006, 100, 200, 40, 8, 700, 700, 700, 700, 700, 700);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(t2.home_team_goal) FROM Player AS t1 INNER JOIN match AS t2 ON t1.player_api_id = t2.away_player_9 WHERE t1.player_name = 'Aaron Lennon';

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT COUNT(M.home_team_goal) AS total_home_team_goals FROM Player AS P JOIN Match AS M ON P.id = M.home_team_api_id WHERE P.player_name = 'Aaron Lennon';

/*
Prediction Result:
(0,)
*/