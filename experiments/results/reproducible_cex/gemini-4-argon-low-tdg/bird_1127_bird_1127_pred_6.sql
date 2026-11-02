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
-- Tests join key specificity: player_api_id vs id vs player_fifa_api_id, and home_player_8 vs other player slots.
INSERT INTO Country (id, name) VALUES (10, 'England');
INSERT INTO Country (id, name) VALUES (20, 'Portugal');
INSERT INTO Country (id, name) VALUES (30, 'Netherlands');
INSERT INTO Country (id, name) VALUES (40, 'Belgium');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (1, 1001, 2001, 'Team Beta', 'BET');
-- Player 1: Valid match on player_api_id = 1000
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (1, 1000, 'Correct Player', 5000);
-- Player 2: Trap where Player.id (1000) or fifa_id matches, or Player_Attributes joins on wrong column
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (2000, 2001, 'Trap ID Player', 6000);
-- Player 3: High vision player placed in wrong match columns (away_player_8, home_player_7, home_player_X8)
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (3, 3000, 'Wrong Position Player', 7000);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, vision) VALUES (10, 5000, 1000, 92);
-- Trap: player_api_id in attributes (2000) matches Player.id (2000), but NOT Player.player_api_id (2001)
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, vision) VALUES (20, 6000, 2000, 95);
-- High vision for Player 3000
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, vision) VALUES (30, 7000, 3000, 93);
-- Match 1: Valid join on home_player_8 = 1000 -> Country 'England'
INSERT INTO Match (id, country_id, league_id, home_team_api_id, home_player_8) VALUES (100, 10, 999, 1001, 1000);
-- Match 2: Trap where home_player_8 matches Player.id (2000) or Player.player_fifa_api_id (5000) -> Country 'Portugal'
INSERT INTO Match (id, country_id, league_id, home_team_api_id, home_player_8) VALUES (200, 20, 999, 1001, 2000);
INSERT INTO Match (id, country_id, league_id, home_team_api_id, home_player_8) VALUES (201, 20, 999, 1001, 5000);
-- Match 3: Trap where Player 3000 is in away_player_8, home_player_7, home_player_9, home_player_X8, home_player_Y8 -> Country 'Netherlands'
INSERT INTO Match (id, country_id, league_id, home_team_api_id, home_player_7, home_player_8, home_player_9, away_player_8, home_player_X8, home_player_Y8) VALUES (300, 30, 999, 1001, 3000, 9999, 3000, 3000, 3000, 3000);
-- Match 4: Trap where league_id is 10 ('England') and country_id is 40 ('Belgium'), but player has low vision, while league_id=40 in another match has high vision
INSERT INTO Match (id, country_id, league_id, home_team_api_id, home_player_8) VALUES (400, 10, 40, 1001, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT t4.name FROM Player_Attributes AS t1 INNER JOIN Player AS t2 ON t1.player_api_id = t2.player_api_id INNER JOIN Match AS t3 ON t2.player_api_id = t3.home_player_8 INNER JOIN Country AS t4 ON t3.country_id = t4.id WHERE t1.vision > 89;

/*
Gold Result:
('England',)
*/

-- Prediction Query
SELECT DISTINCT c.name FROM player_attributes AS pa INNER JOIN player AS p ON pa.player_api_id = p.player_api_id INNER JOIN match AS m ON p.player_api_id = m.home_player_1 OR p.player_api_id = m.home_player_2 OR p.player_api_id = m.home_player_3 OR p.player_api_id = m.home_player_4 OR p.player_api_id = m.home_player_5 OR p.player_api_id = m.home_player_6 OR p.player_api_id = m.home_player_7 OR p.player_api_id = m.home_player_8 OR p.player_api_id = m.home_player_9 OR p.player_api_id = m.home_player_10 OR p.player_api_id = m.home_player_11 OR p.player_api_id = m.away_player_1 OR p.player_api_id = m.away_player_2 OR p.player_api_id = m.away_player_3 OR p.player_api_id = m.away_player_4 OR p.player_api_id = m.away_player_5 OR p.player_api_id = m.away_player_6 OR p.player_api_id = m.away_player_7 OR p.player_api_id = m.away_player_8 OR p.player_api_id = m.away_player_9 OR p.player_api_id = m.away_player_10 OR p.player_api_id = m.away_player_11 INNER JOIN country AS c ON m.country_id = c.id WHERE pa.vision > 89;

/*
Prediction Result:
('England',)
('Netherlands',)
*/