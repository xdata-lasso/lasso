-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'Ireland', 'Dublin', 'Irish');
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (2, 'Dublin', 'London', 'English');
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (3, 'Germany', 'Berlin', 'Dublin');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Shamrock Rovers');
INSERT INTO "team" ("Team_id", "Name") VALUES (2, 'Chelsea');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (1999.0, 1, 1, 'Robbie Keane', 'Forward', 1, '1999', 'UCD');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2000.0, 1, 1, 'Damien Duff', 'Forward', 2, '2000', 'TCD');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2001.0, 1, 1, 'Roy Keane', 'Midfielder', 3, '2001', 'UCC');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2002.0, 1, 1, 'Shay Given', 'Goalkeeper', 4, '2002', 'DCU');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2003.0, 1, 1, 'John OShea', NULL, 5, '2003', 'NUIG');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2004.0, 2, 2, 'Frank Lampard', 'Defender', 6, '2004', 'Oxford');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2005.0, 2, 3, 'Michael Ballack', 'Sweeper', 7, '2005', 'Munich');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "position" FROM (SELECT "country_id", "country_name", "capital", "official_native_language", "season", "player", "position", "team", "draft_pick_number", "draft_class", "college", "country_id" AS "country" FROM (SELECT "LHS"."country_id" AS "country_id", "LHS"."country_name" AS "country_name", "LHS"."capital" AS "capital", "LHS"."official_native_language" AS "official_native_language", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."team" AS "team", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM "country" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country_id" = "RHS"."country"))) WHERE ("capital" = 'Dublin') ORDER BY POSITION, "position" NULLS LAST;

/*
Gold Result:
(None,)
('Forward',)
('Goalkeeper',)
('Midfielder',)
*/

-- Prediction Query
SELECT DISTINCT T2.Position FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id = T2.Country WHERE T1.Capital = 'Dublin';

/*
Prediction Result:
('Forward',)
('Midfielder',)
('Goalkeeper',)
(None,)
*/