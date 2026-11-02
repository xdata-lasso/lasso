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
-- Inserting into table: country --
INSERT INTO "country" ("id", "name") VALUES (1.0, 'cou_9a0d0e');

INSERT INTO "country" ("id", "name") VALUES (2.0, 'cou_15f0ef');

-- Inserting into table: league --
INSERT INTO "league" ("id", "country_id", "name") VALUES (1.0, 1.0, 'lhs_90ccfd');

INSERT INTO "league" ("id", "country_id", "name") VALUES (2.0, 1.0, 'lhs_166b81');

INSERT INTO "league" ("id", "country_id", "name") VALUES (3.0, 1.0, 'lhs_90ccfd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.id AS id, LHS.country_id AS country_id, LHS.name AS name, RHS.name AS name_other FROM league AS LHS INNER JOIN country AS RHS ON (LHS.id = RHS.id)) ORDER BY name___1;

/*
Gold Result:
('cou_15f0ef', 'lhs_166b81')
('cou_9a0d0e', 'lhs_90ccfd')
*/

-- Prediction Query
SELECT T1.name, T2.name FROM Country AS T1 JOIN League AS T2 ON T1.id = T2.country_id;

/*
Prediction Result:
('cou_9a0d0e', 'lhs_90ccfd')
('cou_9a0d0e', 'lhs_166b81')
('cou_9a0d0e', 'lhs_90ccfd')
*/