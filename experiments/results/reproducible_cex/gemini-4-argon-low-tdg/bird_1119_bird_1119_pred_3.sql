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
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (1, 1001, 2001, 'Home United', 'HOM');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (2, 1002, 2002, 'Away City', 'AWY');
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (1, 30829, 'Aaron Lennon', 152747);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (2, 30830, 'Wayne Rooney', 152748);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (3, 152747, 'Decoy Fifa ID', 999991);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (4, 1, 'Decoy Primary ID', 999992);
-- Match 1: Valid match for Aaron Lennon in away_player_9
INSERT INTO "Match" (id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9, home_player_9, away_player_8) VALUES (10, 1001, 1002, 2, 5, 30829, 30830, 30830);
-- Match 2: Valid match with duplicate home_team_goal value (2) to kill SUM(DISTINCT) vs SUM(), AVG, COUNT, MIN, MAX
INSERT INTO "Match" (id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9) VALUES (11, 1001, 1002, 2, 1, 30829);
-- Match 3: Valid match with different home_team_goal value (3)
INSERT INTO "Match" (id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9) VALUES (12, 1001, 1002, 3, 0, 30829);
-- Match 4: Wrong player in away_player_9 (kills missing WHERE player_name filter)
INSERT INTO "Match" (id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9) VALUES (13, 1001, 1002, 10, 4, 30830);
-- Match 5: Aaron Lennon in home_player_9 instead of away_player_9
INSERT INTO "Match" (id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, home_player_9, away_player_9) VALUES (14, 1001, 1002, 20, 4, 30829, 30830);
-- Match 6: Aaron Lennon in away_player_8, away_player_10, away_player_X9, away_player_Y9
INSERT INTO "Match" (id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_8, away_player_10, away_player_X9, away_player_Y9, away_player_9) VALUES (15, 1001, 1002, 40, 4, 30829, 30829, 30829, 30829, 30830);
-- Match 7: Join column uses Aaron Lennon's player_fifa_api_id (152747) instead of player_api_id
INSERT INTO "Match" (id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9) VALUES (16, 1001, 1002, 80, 4, 152747);
-- Match 8: Join column uses Aaron Lennon's primary key id (1) instead of player_api_id
INSERT INTO "Match" (id, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal, away_player_9) VALUES (17, 1001, 1002, 160, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(t2.home_team_goal) FROM Player AS t1 INNER JOIN match AS t2 ON t1.player_api_id = t2.away_player_9 WHERE t1.player_name = 'Aaron Lennon';

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT SUM(home_team_goal) FROM Match WHERE home_player_1 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_2 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_3 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_4 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_5 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_6 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_7 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_8 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_9 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_10 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_11 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon');

/*
Prediction Result:
(20,)
*/