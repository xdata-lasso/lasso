-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1001, 'Northern Mariana Islands', 'brother', 'ago');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1006, 'Northern Mariana Islands', 'brother', 'ago');
INSERT INTO "team" ("team_id", "name") VALUES (1002, 'Danielle Taylor');
INSERT INTO "team" ("team_id", "name") VALUES (1008, 'Danielle Taylor');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1003.5, 1002, 1001, 'blue', 'require', 1004, 'sit', 'UCLA');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1009.5, NULL, 1001, NULL, 'require', 1004, 'sit', 'UCLA');
INSERT INTO "player" ("player_id", "team", "player", "years_played", "total_wl", "singles_wl", "doubles_wl") VALUES (1005, 1002, 'blue', 'wait', 'offer', 'begin', 'performance');
INSERT INTO "player" ("player_id", "team", "player", "years_played", "total_wl", "singles_wl", "doubles_wl") VALUES (1010, NULL, NULL, 'wait', 'offer', 'begin', 'performance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player" FROM (SELECT "LHS"."season" AS "season", "LHS"."player" AS "player", "LHS"."position" AS "position", "LHS"."country" AS "country", "LHS"."team" AS "team", "LHS"."draft_pick_number" AS "draft_pick_number", "LHS"."draft_class" AS "draft_class", "LHS"."college" AS "college", "RHS"."player_id" AS "player_id", "RHS"."years_played" AS "years_played", "RHS"."total_wl" AS "total_wl", "RHS"."singles_wl" AS "singles_wl", "RHS"."doubles_wl" AS "doubles_wl" FROM (SELECT * FROM "match_season" WHERE ("college" = 'UCLA')) AS LHS LEFT JOIN player AS RHS ON (LHS.player = RHS.player AND LHS.team = RHS.team)) ORDER BY player, "player" NULLS LAST;

/*
Gold Result:
(None,)
('blue',)
*/

-- Prediction Query
SELECT Player FROM match_season WHERE College = 'UCLA';

/*
Prediction Result:
('blue',)
(None,)
*/