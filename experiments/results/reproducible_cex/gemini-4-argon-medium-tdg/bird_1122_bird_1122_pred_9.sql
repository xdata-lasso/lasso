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
-- Tests:
-- 1. INNER JOIN vs LEFT/RIGHT JOIN (unmatched Player rows, unmatched Player_Attributes rows via NULL FK).
-- 2. Join condition on player_api_id vs player_fifa_api_id or id.
-- 3. DISTINCT requirement (multiple attribute rows for the same player).
-- 4. ORDER BY overall_rating DESC (vs ASC, or ordering by potential).
-- 5. Tie-breaking by player_name ASC with NULLS LAST.
-- 6. LIMIT 10 boundary (12 distinct matching players generated).
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (1, 101, 'Alice', 1001);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (2, 102, 'Bob', 1002);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (3, 103, NULL, 1003);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (4, 104, 'Charlie', 1004);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (5, 105, 'David', 1005);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (6, 106, 'Eve', 1006);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (7, 107, 'Frank', 1007);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (8, 108, 'Grace', 1008);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (9, 109, 'Heidi', 1009);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (10, 110, 'Ivan', 1010);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (11, 111, 'Judy', 1011);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (12, 112, 'Karl', 1012);
INSERT INTO Player (id, player_api_id, player_name, player_fifa_api_id) VALUES (13, 113, 'NoAttributesPlayer', 1013);
-- Alice has two records with the highest rating (tests DISTINCT)
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (1, 1001, 101, 95, 70);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (2, 1001, 101, 95, 75);
-- Bob, NULL-named player, and Charlie tie at 90 (tests tie-breaker player_name ASC NULLS LAST)
-- Also tests join on player_api_id vs player_fifa_api_id by cross-referencing valid player_fifa_api_id values
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (3, 1003, 102, 90, 80);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (4, 1004, 103, 90, 85);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (5, 1002, 104, 90, 99);
-- Remaining players to exceed LIMIT 10
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (6, 1005, 105, 88, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (7, 1006, 106, 87, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (8, 1007, 107, 86, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (9, 1008, 108, 85, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (10, 1009, 109, 84, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (11, 1010, 110, 83, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (12, 1011, 111, 82, 90);
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (13, 1012, 112, 81, 90);
-- Unmatched attribute row (player_api_id 999 does not exist in Player)
INSERT INTO Player_Attributes (id, player_fifa_api_id, player_api_id, overall_rating, potential) VALUES (14, NULL, 999, 99, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT t1.player_name FROM Player AS t1 INNER JOIN Player_Attributes AS t2 ON t1.player_api_id = t2.player_api_id ORDER BY t2.overall_rating DESC, t1.player_name NULLS LAST LIMIT 10;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
(None,)
('David',)
('Eve',)
('Frank',)
('Grace',)
('Heidi',)
('Ivan',)
*/

-- Prediction Query
SELECT T1.player_name FROM Player AS T1 INNER JOIN Player_Attributes AS T2 ON T1.player_api_id = T2.player_api_id AND T1.player_fifa_api_id = T2.player_fifa_api_id WHERE T2.overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes);

/*
Prediction Result:
*/