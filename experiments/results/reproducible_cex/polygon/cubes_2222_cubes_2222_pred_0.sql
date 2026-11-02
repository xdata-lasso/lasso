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
INSERT INTO "Country" ("id", "name") VALUES (31, '33');
INSERT INTO "Country" ("id", "name") VALUES (18, '33');
INSERT INTO "League" ("id", "country_id", "name") VALUES (31, NULL, '34');
INSERT INTO "League" ("id", "country_id", "name") VALUES (18, 18, '34');
INSERT INTO "Team" ("id", "team_api_id", "team_fifa_api_id", "team_long_name", "team_short_name") VALUES (20, NULL, 18, '18', '18');
INSERT INTO "Team" ("id", "team_api_id", "team_fifa_api_id", "team_long_name", "team_short_name") VALUES (19, 16, 18, '18', '18');
INSERT INTO "Team_Attributes" ("id", "team_api_id", "date", "buildupplayspeed") VALUES (22, 16, '18', 18);
INSERT INTO "Team_Attributes" ("id", "team_api_id", "date", "buildupplayspeed") VALUES (21, 16, '18', 18);
INSERT INTO "Player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (24, 17, '18', 18, '18', 18, 18);
INSERT INTO "Player" ("id", "player_api_id", "player_name", "player_fifa_api_id", "birthday", "height", "weight") VALUES (23, NULL, '18', 18, '18', 18, 18);
INSERT INTO "Player_Attributes" ("id", "player_api_id", "date", "overall_rating", "potential") VALUES (26, 17, '18', 18, 18);
INSERT INTO "Player_Attributes" ("id", "player_api_id", "date", "overall_rating", "potential") VALUES (25, 17, '18', 18, 18);
INSERT INTO "Match" ("id", "country_id", "league_id", "home_team_api_id", "away_team_api_id", "season", "stage", "date", "match_api_id", "home_team_goal", "away_team_goal") VALUES (18, 31, 18, 16, 16, '18', 18, '18', 18, 18, 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.id AS id, LHS.country_id AS country_id, LHS.name AS name, RHS.name AS name_other FROM league AS LHS INNER JOIN country AS RHS ON (LHS.id = RHS.id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('33', '34')
('33', '34')
*/

-- Prediction Query
SELECT T1.name, T2.name FROM Country AS T1 JOIN League AS T2 ON T1.id = T2.country_id;

/*
Prediction Result:
('33', '34')
*/