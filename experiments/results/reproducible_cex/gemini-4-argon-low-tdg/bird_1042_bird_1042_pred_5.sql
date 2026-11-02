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
-- DATASET 5
-- Tests JOIN condition (t1.id = t2.league_id vs t1.country_id = t2.country_id or t1.id = t2.country_id)
-- and tests NULL values in home_team_goal / away_team_goal (AVG vs SUM / COUNT(DISTINCT id))
INSERT INTO Country (id, name) VALUES (10, 'Germany');
INSERT INTO Country (id, name) VALUES (20, 'France');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (1, 401, 4001, 'Bayern', 'BAY');
INSERT INTO Team (id, team_api_id, team_fifa_api_id, team_long_name, team_short_name) VALUES (2, 402, 4002, 'Dortmund', 'BVB');
-- League 10 has id=10, country_id=20. League 20 has id=20, country_id=10.
INSERT INTO League (id, country_id, name) VALUES (10, 20, 'Bundesliga');
INSERT INTO League (id, country_id, name) VALUES (20, 10, 'Ligue 1');
-- Match 1 belongs to league_id=10, country_id=20 (Home=5, Away=1 -> Positive diff for League 10)
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (1, 20, 10, '2009/2010', 401, 402, 5, 1);
-- Match 2 belongs to league_id=20, country_id=10 (Home=0, Away=4 -> Negative diff for League 20)
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (2, 10, 20, '2009/2010', 401, 402, 0, 4);
-- League 30: Tests AVG(home_team_goal) - AVG(away_team_goal) vs (SUM(home)/COUNT(id)) - (SUM(away)/COUNT(id)) in presence of NULLs.
-- Match 3: home=4, away=NULL. Match 4: home=0, away=3. Match 5: home=0, away=3.
-- Total COUNT(DISTINCT id) = 3.
-- Gold Query: SUM(home)/3 = 4/3 = 1.333. SUM(away)/3 = 6/3 = 2.0. Diff = 1.333 - 2.0 = -0.667 (NOT > 0).
-- Mutant with AVG(home) - AVG(away): AVG(home) = 4/3 = 1.333. AVG(away) = 6/2 = 3.0.
-- Let's construct the reverse where AVG gives > 0 and Gold gives < 0:
-- Match 3: home=5, away=0. Match 4: home=NULL, away=3. Match 5: home=NULL, away=3.
-- Gold Query: SUM(home)/3 = 5/3 = 1.667. SUM(away)/3 = 6/3 = 2.0. Diff = -0.333 (NOT > 0).
-- Mutant with AVG: AVG(home) = 5/1 = 5.0. AVG(away) = 6/3 = 2.0. Diff = +3.0 (> 0, Mutant falsely returns League 30).
INSERT INTO League (id, country_id, name) VALUES (30, 10, 'Null Test League');
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (3, 10, 30, '2009/2010', 401, 402, 5, 0);
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (4, 10, 30, '2009/2010', 401, 402, NULL, 3);
INSERT INTO Match (id, country_id, league_id, season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal) VALUES (5, 10, 30, '2009/2010', 401, 402, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT t1.name FROM League AS t1 INNER JOIN Match AS t2 ON t1.id = t2.league_id WHERE t2.season = '2009/2010' GROUP BY t1.name HAVING (CAST(SUM(t2.home_team_goal) AS REAL) / COUNT(DISTINCT t2.id)) - (CAST(SUM(t2.away_team_goal) AS REAL) / COUNT(DISTINCT t2.id)) > 0;

/*
Gold Result:
('Bundesliga',)
*/

-- Prediction Query
SELECT T1.name FROM League AS T1 INNER JOIN Match AS T2 ON T1.id = T2.league_id WHERE T2.season = '2009/2010' GROUP BY T1.name HAVING AVG(T2.home_team_goal) > AVG(T2.away_team_goal);

/*
Prediction Result:
('Bundesliga',)
('Null Test League',)
*/