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
INSERT INTO Country (id, name) VALUES (1, 'England');
INSERT INTO Country (id, name) VALUES (2, 'Spain');
INSERT INTO Country (id, name) VALUES (3, 'Germany');
INSERT INTO Country (id, name) VALUES (4, 'France');
INSERT INTO League (id, country_id, name) VALUES (1, 1, 'England');
INSERT INTO League (id, country_id, name) VALUES (2, 1, 'Premier League');
INSERT INTO League (id, country_id, name) VALUES (3, 2, 'La Liga');
INSERT INTO League (id, country_id, name) VALUES (5, 2, 'Segunda Division');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "LHS"."id" AS "id", "LHS"."n" AS "n", "RHS"."name" AS "name" FROM (SELECT "id", COUNT(*) AS "n" FROM "league" WHERE ("name" <> 'England') GROUP BY id) AS LHS INNER JOIN country AS RHS ON (LHS.id = RHS.id)) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Country AS T1 JOIN League AS T2 ON T1.id = T2.country_id WHERE T1.name = 'England';

/*
Prediction Result:
(2,)
*/