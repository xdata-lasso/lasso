-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (2, 'Canada', 'Ottawa', 'English');
INSERT INTO "team" ("Team_id", "Name") VALUES (10, 'Alpha');
INSERT INTO "team" ("Team_id", "Name") VALUES (20, 'Beta');
INSERT INTO "team" ("Team_id", "Name") VALUES (30, 'Gamma');
-- LHS valid row: Midfielder, Country 1, Team 10
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2001.0, 10, 1, 'P1', 'Midfielder', 99, '2001', 'College_LHS');
-- RHS valid match 1 (for ORDER BY and DISTINCT testing): Country 1, Draft_Pick_Number 10 -> Z_College
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2002.0, 20, 1, 'P2', 'Defender', 10, '2002', 'Z_College');
-- RHS valid match 2 (duplicate college to test DISTINCT): Country 1, Draft_Pick_Number 10 -> Z_College
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2003.0, 30, 1, 'P3', 'Forward', 10, '2003', 'Z_College');
-- RHS valid match 3 (for ORDER BY ASC vs DESC): Country 1, Draft_Pick_Number 10 -> A_College
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2004.0, 20, 1, 'P4', 'Defender', 10, '2004', 'A_College');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "college_other" AS "college" FROM (SELECT "season", "player", "position", "country", "team", "team" AS "draft_pick_number", "draft_class", "college", "season_other", "player_other", "position_other", "team_other", "draft_class_other", "college_other" FROM (SELECT "LHS"."season" AS "season", "LHS"."player" AS "player", "LHS"."position" AS "position", "LHS"."country" AS "country", "LHS"."team" AS "team", "LHS"."draft_pick_number" AS "draft_pick_number", "LHS"."draft_class" AS "draft_class", "LHS"."college" AS "college", "RHS"."season" AS "season_other", "RHS"."player" AS "player_other", "RHS"."position" AS "position_other", "RHS"."team" AS "team_other", "RHS"."draft_class" AS "draft_class_other", "RHS"."college" AS "college_other" FROM "match_season" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country" = "RHS"."country" AND "LHS"."team" = "RHS"."draft_pick_number"))) WHERE ("position" = 'Midfielder' AND "position" <> 'Defender') ORDER BY college;

/*
Gold Result:
('A_College',)
('Z_College',)
*/

-- Prediction Query
SELECT College FROM match_season WHERE POSITION = 'Midfielder' INTERSECT SELECT College FROM match_season WHERE POSITION = 'Defender';

/*
Prediction Result:
*/