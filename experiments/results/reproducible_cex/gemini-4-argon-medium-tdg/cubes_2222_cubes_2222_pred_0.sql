-- Schema DDL
CREATE TABLE "Country" ("id" REAL(5, 0) PRIMARY KEY, "name" TEXT(50));

CREATE TABLE "League" ("id" REAL(5, 0) PRIMARY KEY, "country_id" REAL(5, 0), "name" TEXT(50), FOREIGN KEY ("country_id") REFERENCES "Country" ("id"));

CREATE TABLE "Team" ("id" REAL(5, 0) PRIMARY KEY, "team_api_id" REAL(5, 0) UNIQUE, "team_fifa_api_id" REAL(5, 0), "team_long_name" TEXT(50), "team_short_name" TEXT(10));

CREATE TABLE "Team_Attributes" ("id" REAL(5, 0) PRIMARY KEY, "team_api_id" REAL(5, 0), "date" TEXT(20), "buildUpPlaySpeed" REAL(5, 0), FOREIGN KEY ("team_api_id") REFERENCES "Team" ("team_api_id"));

CREATE TABLE "Player" ("id" REAL(5, 0) PRIMARY KEY, "player_api_id" REAL(5, 0) UNIQUE, "player_name" TEXT(50), "player_fifa_api_id" REAL(5, 0), "birthday" TEXT(20), "height" REAL(5, 0), "weight" REAL(5, 0));

CREATE TABLE "Player_Attributes" ("id" REAL(5, 0) PRIMARY KEY, "player_api_id" REAL(5, 0), "date" TEXT(20), "overall_rating" REAL(5, 0), "potential" REAL(5, 0), FOREIGN KEY ("player_api_id") REFERENCES "Player" ("player_api_id"));

CREATE TABLE "Match" ("id" REAL(5, 0) PRIMARY KEY, "country_id" REAL(5, 0), "league_id" REAL(5, 0), "home_team_api_id" REAL(5, 0), "away_team_api_id" REAL(5, 0), "season" TEXT(20), "stage" REAL(5, 0), "date" TEXT(20), "match_api_id" REAL(5, 0), "home_team_goal" REAL(5, 0), "away_team_goal" REAL(5, 0), FOREIGN KEY ("country_id") REFERENCES "Country" ("id"), FOREIGN KEY ("league_id") REFERENCES "League" ("id"), FOREIGN KEY ("home_team_api_id") REFERENCES "Team" ("team_api_id"), FOREIGN KEY ("away_team_api_id") REFERENCES "Team" ("team_api_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests join condition (LHS.id = RHS.id vs LHS.country_id = RHS.id), column ordering, and sorting direction (ORDER BY name___1 vs name___2 vs id).
INSERT INTO "Country" ("id", "name") VALUES (1, 'Zulu');
INSERT INTO "Country" ("id", "name") VALUES (2, 'Alpha');
INSERT INTO "Country" ("id", "name") VALUES (3, 'Mid');
INSERT INTO "League" ("id", "country_id", "name") VALUES (1, 2, 'Aleague');
INSERT INTO "League" ("id", "country_id", "name") VALUES (2, 1, 'Zleague');
INSERT INTO "League" ("id", "country_id", "name") VALUES (4, 3, 'UnmatchedLeague');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.id AS id, LHS.country_id AS country_id, LHS.name AS name, RHS.name AS name_other FROM league AS LHS INNER JOIN country AS RHS ON (LHS.id = RHS.id)) ORDER BY name___1;

/*
Gold Result:
('Alpha', 'Zleague')
('Zulu', 'Aleague')
*/

-- Prediction Query
SELECT T1.name, T2.name FROM Country AS T1 JOIN League AS T2 ON T1.id = T2.country_id;

/*
Prediction Result:
('Alpha', 'Aleague')
('Zulu', 'Zleague')
('Mid', 'UnmatchedLeague')
*/