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
-- DATASET 3
-- Tests difference between SUM(buildUpPlayPassing)/COUNT(t1.id) and AVG(buildUpPlayPassing) in the presence of NULLs.
-- Also tests join key confusion (team_api_id vs team_fifa_api_id vs id).
-- Team 1: api_id=301, fifa=3001. Passing=60.
-- Team 2: api_id=302, fifa=3002. Passing=40.
-- Team 3: api_id=303, fifa=3003. Passing=NULL.
-- With NULL: SUM = 100, COUNT(t1.id) = 3. 100 / 3 = 33.333. Both Team 1 (60) and Team 2 (40) are > 33.333!
-- If mutant uses AVG(buildUpPlayPassing) or COUNT(buildUpPlayPassing): 100 / 2 = 50.0. Only Team 1 (60) would be > 50.0!
-- Team 4: Orphaned/Mismatched team_api_id in Team_Attributes (has valid team_fifa_api_id=3001, but unmatched team_api_id=999). Tests INNER JOIN on team_api_id in subquery and outer query.
INSERT INTO "Team" ("id", "team_api_id", "team_fifa_api_id", "team_long_name", "team_short_name") VALUES (1, 301, 3001, 'Team Sixty', 'SIX');
INSERT INTO "Team" ("id", "team_api_id", "team_fifa_api_id", "team_long_name", "team_short_name") VALUES (2, 302, 3002, 'Team Forty', 'FOR');
INSERT INTO "Team" ("id", "team_api_id", "team_fifa_api_id", "team_long_name", "team_short_name") VALUES (3, 303, 3003, 'Team Null', 'NUL');
INSERT INTO "Team_Attributes" ("id", "team_fifa_api_id", "team_api_id", "date", "buildUpPlayPassing") VALUES (10, 3001, 301, '2012-02-22', 60);
INSERT INTO "Team_Attributes" ("id", "team_fifa_api_id", "team_api_id", "date", "buildUpPlayPassing") VALUES (20, 3002, 302, '2012-02-22', 40);
INSERT INTO "Team_Attributes" ("id", "team_fifa_api_id", "team_api_id", "date", "buildUpPlayPassing") VALUES (30, 3003, 303, '2012-02-22', NULL);
INSERT INTO "Team_Attributes" ("id", "team_fifa_api_id", "team_api_id", "date", "buildUpPlayPassing") VALUES (40, 3001, 999, '2012-02-22', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT t4.team_long_name FROM Team_Attributes AS t3 INNER JOIN Team AS t4 ON t3.team_api_id = t4.team_api_id WHERE SUBSTRING(t3."date", 1, 4) = '2012' AND t3.buildUpPlayPassing > (SELECT CAST(SUM(t2.buildUpPlayPassing) AS REAL) / COUNT(t1.id) FROM Team AS t1 INNER JOIN Team_Attributes AS t2 ON t1.team_api_id = t2.team_api_id WHERE SUBSTRING(t2."date", 1, 4) = '2012');

/*
Gold Result:
('Team Sixty',)
('Team Forty',)
*/

-- Prediction Query
SELECT DISTINCT "Team"."team_long_name" FROM "Team_Attributes" INNER JOIN "Team" ON "Team_Attributes"."team_api_id" = "Team"."team_api_id" WHERE STRFTIME('%Y', "Team_Attributes"."date") = '2012' AND "Team_Attributes"."buildUpPlayPassing" > (SELECT AVG("buildUpPlayPassing") FROM "Team_Attributes" WHERE STRFTIME('%Y', "date") = '2012' AND NOT "buildUpPlayPassing" IS NULL);

/*
Prediction Result:
*/