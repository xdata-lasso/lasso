-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1037, 'Niger', 'value', 'training');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1045, 'Timor-Leste', 'early', 'trial');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1041, NULL, NULL, NULL);
INSERT INTO "team" ("team_id", "name") VALUES (1038, 'Ryley Goldner');
INSERT INTO "team" ("team_id", "name") VALUES (1046, 'Ryley Goldner');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1039.5, 1038, 1037, 'high', 'participant', 1040, 'dark', 'sea');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1043.5, 1038, 1041, 'drive', 'spring', 1044, 'figure', 'base');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1047.5, 1046, 1045, 'blood', 'husband', 1048, 'fall', 'long');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "position" FROM (SELECT "LHS"."team_id" AS "team_id", "LHS"."name" AS "name", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."country" AS "country", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM (SELECT * FROM "team" WHERE ("name" = 'Ryley Goldner')) AS LHS INNER JOIN match_season AS RHS ON (LHS.team_id = RHS.team)) ORDER BY POSITION, "position" NULLS LAST;

/*
Gold Result:
('husband',)
('participant',)
('spring',)
*/

-- Prediction Query
SELECT T1.Position FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id WHERE T2.Name = 'Ryley Goldner';

/*
Prediction Result:
('participant',)
('spring',)
('husband',)
*/