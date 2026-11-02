-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests LEFT JOIN vs INNER JOIN, college filter ('UCLA' vs others/NULL), and ORDER BY NULLS LAST
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Lakers');
INSERT INTO "team" ("Team_id", "Name") VALUES (2, 'Celtics');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2020.0, 1, 1, 'Zack', 'Guard', 1, '2020', 'UCLA');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2021.0, 1, 1, 'Aaron', 'Forward', 2, '2021', 'UCLA');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2022.0, 1, 1, NULL, 'Center', 3, '2022', 'UCLA');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2023.0, 1, 1, 'Bob', 'Guard', 4, '2023', 'USC');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2024.0, 1, 1, 'Charlie', 'Forward', 5, '2024', NULL);
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (101, 1, 'Aaron', '2', '10-2', '5-1', '5-1');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (102, 1, 'Bob', '1', '5-5', '2-3', '3-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player" FROM (SELECT "LHS"."season" AS "season", "LHS"."player" AS "player", "LHS"."position" AS "position", "LHS"."country" AS "country", "LHS"."team" AS "team", "LHS"."draft_pick_number" AS "draft_pick_number", "LHS"."draft_class" AS "draft_class", "LHS"."college" AS "college", "RHS"."player_id" AS "player_id", "RHS"."years_played" AS "years_played", "RHS"."total_wl" AS "total_wl", "RHS"."singles_wl" AS "singles_wl", "RHS"."doubles_wl" AS "doubles_wl" FROM (SELECT * FROM "match_season" WHERE ("college" = 'UCLA')) AS LHS LEFT JOIN player AS RHS ON (LHS.player = RHS.player AND LHS.team = RHS.team)) ORDER BY player, "player" NULLS LAST;

/*
Gold Result:
(None,)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT Player FROM match_season WHERE College = 'UCLA';

/*
Prediction Result:
('Zack',)
('Aaron',)
(None,)
*/