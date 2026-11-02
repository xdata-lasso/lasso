-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (2, 'Spain', 'Madrid', 'Spanish');
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (3, 'France', 'Paris', 'French');
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (4, 'Antarctica', 'None', NULL);
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (5, 'Germany', 'Berlin', 'German');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Tigers');
INSERT INTO "team" ("Team_id", "Name") VALUES (2, 'Bears');
INSERT INTO "team" ("Team_id", "Name") VALUES (5, 'Lions');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2001.0, 5, 2, 'Player A', 'Guard', 5, '2001', 'Maryland');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2002.0, 5, 1, 'Player B', 'Forward', 5, '2002', 'Duke');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2003.0, 1, 1, 'Player C', 'Center', 2, '2003', 'Maryland');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2004.0, 2, 4, 'Player D', 'Guard', 3, '2004', 'Duke');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2005.0, 1, 3, 'Player E', 'Forward', 1, '2005', 'UNC');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2006.0, 2, NULL, 'Player F', 'Center', 4, '2006', 'Maryland');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2007.0, 1, 5, 'Player G', 'Guard', 1, '2007', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "official_native_language" FROM (SELECT "country_id", "country_name", "capital", "official_native_language", "season", "player", "position", "team", "draft_pick_number", "draft_class", "college", "country_id" AS "country" FROM (SELECT "LHS"."country_id" AS "country_id", "LHS"."country_name" AS "country_name", "LHS"."capital" AS "capital", "LHS"."official_native_language" AS "official_native_language", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."team" AS "team", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM "country" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country_id" = "RHS"."country"))) WHERE ("college" = 'Maryland' OR "college" = 'Duke') ORDER BY official_native_language, "official_native_language" NULLS LAST;

/*
Gold Result:
(None,)
('English',)
('English',)
('Spanish',)
*/

-- Prediction Query
SELECT T1.Official_native_language FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id = T2.Country WHERE T2.College = 'Maryland' OR T2.College = 'Duke';

/*
Prediction Result:
('Spanish',)
('English',)
('English',)
(None,)
*/