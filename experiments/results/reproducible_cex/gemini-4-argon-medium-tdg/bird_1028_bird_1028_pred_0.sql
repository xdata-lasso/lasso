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
INSERT INTO Country (id, name) VALUES (1, 'Scotland');
INSERT INTO League (id, country_id, name) VALUES (1, 1, 'Scotland Premier League');
-- Tests tie-breaker on team_long_name ASC NULLS LAST and GROUP BY away_team_api_id vs team_long_name
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (1, 201, 2001, NULL, 'NUL');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (2, 202, 2002, 'Beta FC', 'BET');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (3, 203, 2003, 'Alpha FC', 'ALP');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (4, 204, 2004, 'Duplicate Name FC', 'DN1');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (5, 205, 2005, 'Duplicate Name FC', 'DN2');
-- Team 201 (NULL name): 2 wins
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (1, 1, 1, '2009/2010', 202, 201, 0, 1);
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (2, 1, 1, '2009/2010', 203, 201, 0, 1);
-- Team 202 ('Beta FC'): 2 wins
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (3, 1, 1, '2009/2010', 201, 202, 0, 1);
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (4, 1, 1, '2009/2010', 203, 202, 0, 1);
-- Team 203 ('Alpha FC'): 2 wins (Should win tie-breaker over 'Beta FC' and NULL)
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (5, 1, 1, '2009/2010', 201, 203, 0, 1);
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (6, 1, 1, '2009/2010', 202, 203, 0, 1);
-- Team 204 & 205 (Both named 'Duplicate Name FC'): 1 win and 2 wins respectively.
-- If grouped by team_long_name instead of away_team_api_id, 'Duplicate Name FC' gets 3 wins and falsely takes 1st place.
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (7, 1, 1, '2009/2010', 201, 204, 0, 1);
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (8, 1, 1, '2009/2010', 201, 205, 0, 1);
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (9, 1, 1, '2009/2010', 202, 205, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT teamInfo.team_long_name FROM League AS leagueData INNER JOIN Match AS matchData ON leagueData.id = matchData.league_id INNER JOIN Team AS teamInfo ON matchData.away_team_api_id = teamInfo.team_api_id WHERE leagueData.name = 'Scotland Premier League' AND matchData.season = '2009/2010' AND matchData.away_team_goal - matchData.home_team_goal > 0 GROUP BY matchData.away_team_api_id ORDER BY COUNT(*) DESC, teamInfo.team_long_name NULLS LAST LIMIT 1;

/*
Gold Result:
('Alpha FC',)
*/

-- Prediction Query
SELECT T1.team_long_name FROM Team AS T1 INNER JOIN (SELECT away_team_api_id, COUNT(*) AS wins FROM Match WHERE league_id IN (SELECT id FROM League WHERE name = 'Scotland Premier League') AND season = '2009/2010' AND away_team_goal > home_team_goal GROUP BY away_team_api_id ORDER BY wins DESC, away_team_api_id NULLS LAST LIMIT 1) AS T2 ON T1.team_api_id = T2.away_team_api_id;

/*
Prediction Result:
(None,)
*/