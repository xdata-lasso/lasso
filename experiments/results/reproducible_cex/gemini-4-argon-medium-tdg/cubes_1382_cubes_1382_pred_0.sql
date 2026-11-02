-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Ryley Goldner');
INSERT INTO "team" ("Team_id", "Name") VALUES (2, 'Other Team');
INSERT INTO "team" ("Team_id", "Name") VALUES (3, 'Ryley Goldner');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2001.0, 1, 1, 'Player A', 'Forward', 10, '2001', 'Duke');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2002.0, 1, 1, 'Player B', 'Center', 5, '2002', 'UNC');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2003.0, 1, 1, 'Player C', 'Forward', 12, '2003', 'UCLA');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2004.0, 1, 1, 'Player D', NULL, 20, '2004', 'Kentucky');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2005.0, 2, 1, 'Player E', 'Defender', 1, '2005', 'Kansas');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "position" FROM (SELECT "LHS"."team_id" AS "team_id", "LHS"."name" AS "name", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."country" AS "country", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM (SELECT * FROM "team" WHERE ("name" = 'Ryley Goldner')) AS LHS INNER JOIN match_season AS RHS ON (LHS.team_id = RHS.team)) ORDER BY POSITION, "position" NULLS LAST;

/*
Gold Result:
(None,)
('Center',)
('Forward',)
('Forward',)
*/

-- Prediction Query
SELECT T1.Position FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id WHERE T2.Name = 'Ryley Goldner';

/*
Prediction Result:
('Forward',)
('Center',)
('Forward',)
(None,)
*/