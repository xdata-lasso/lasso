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
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (3, 'France', 'Paris', 'French');
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (4, 'Emptyland', 'Dublin', 'English');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Dublin');
INSERT INTO "team" ("Team_id", "Name") VALUES (2, 'Celtics');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2020.0, 2, 1, 'Player A', 'Forward', 1, '2020', 'UCD');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2021.0, 2, 1, 'Player B', 'Forward', 2, '2021', 'TCD');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2022.0, 2, 1, 'Player C', 'Defender', 3, '2022', 'DCU');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2023.0, 2, 1, 'Player D', NULL, 4, '2023', 'UCC');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2024.0, 1, 2, 'Player E', 'Midfielder', 5, '2024', 'Oxford');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2025.0, 1, 3, 'Player F', 'Striker', 6, '2025', 'Sorbonne');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2026.0, NULL, NULL, 'Player G', 'Goalie', 7, '2026', 'None');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (1, 1, 'Player E', '2024', '10-0', '5-0', '5-0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "position" FROM (SELECT "country_id", "country_name", "capital", "official_native_language", "season", "player", "position", "team", "draft_pick_number", "draft_class", "college", "country_id" AS "country" FROM (SELECT "LHS"."country_id" AS "country_id", "LHS"."country_name" AS "country_name", "LHS"."capital" AS "capital", "LHS"."official_native_language" AS "official_native_language", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."team" AS "team", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM "country" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country_id" = "RHS"."country"))) WHERE ("capital" = 'Dublin') ORDER BY POSITION, "position" NULLS LAST;

/*
Gold Result:
(None,)
('Defender',)
('Forward',)
*/

-- Prediction Query
SELECT DISTINCT T2.Position FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id = T2.Country WHERE T1.Capital = 'Dublin';

/*
Prediction Result:
('Forward',)
('Defender',)
(None,)
*/