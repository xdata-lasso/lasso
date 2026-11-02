-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1001, 'Northern Mariana Islands', 'brother', 'ago');
INSERT INTO "team" ("team_id", "name") VALUES (1002, 'Danielle Taylor');
INSERT INTO "team" ("team_id", "name") VALUES (1006, NULL);
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1003.5, 1002, 1001, 'blue', 'Midfielder', 1004, 'require', 'sit');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1005.5, 1006, 1001, 'wait', 'offer', 1002, 'begin', 'performance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "college_other" AS "college" FROM (SELECT "season", "player", "position", "country", "team", "team" AS "draft_pick_number", "draft_class", "college", "season_other", "player_other", "position_other", "team_other", "draft_class_other", "college_other" FROM (SELECT "LHS"."season" AS "season", "LHS"."player" AS "player", "LHS"."position" AS "position", "LHS"."country" AS "country", "LHS"."team" AS "team", "LHS"."draft_pick_number" AS "draft_pick_number", "LHS"."draft_class" AS "draft_class", "LHS"."college" AS "college", "RHS"."season" AS "season_other", "RHS"."player" AS "player_other", "RHS"."position" AS "position_other", "RHS"."team" AS "team_other", "RHS"."draft_class" AS "draft_class_other", "RHS"."college" AS "college_other" FROM "match_season" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country" = "RHS"."country" AND "LHS"."team" = "RHS"."draft_pick_number"))) WHERE ("position" = 'Midfielder' AND "position" <> 'Defender') ORDER BY college;

/*
Gold Result:
('performance',)
*/

-- Prediction Query
SELECT College FROM match_season WHERE POSITION = 'Midfielder' INTERSECT SELECT College FROM match_season WHERE POSITION = 'Defender';

/*
Prediction Result:
*/