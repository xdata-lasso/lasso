-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1047, 'Western Sahara', 'Dublin', 'our');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1055, 'Ukraine', 'Dublin', 'past');
INSERT INTO "team" ("team_id", "name") VALUES (1048, 'Emily Rios');
INSERT INTO "team" ("team_id", "name") VALUES (1056, 'Daniel Bright');
INSERT INTO "team" ("team_id", "name") VALUES (1052, NULL);
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1049.5, 1048, 1047, 'individual', 'usually', 1050, 'who', 'question');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1053.5, 1052, 1047, 'everyone', 'skin', 1054, 'pattern', 'later');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1057.5, 1056, 1055, 'Mr', 'minute', 1058, 'benefit', 'someone');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "position" FROM (SELECT "country_id", "country_name", "capital", "official_native_language", "season", "player", "position", "team", "draft_pick_number", "draft_class", "college", "country_id" AS "country" FROM (SELECT "LHS"."country_id" AS "country_id", "LHS"."country_name" AS "country_name", "LHS"."capital" AS "capital", "LHS"."official_native_language" AS "official_native_language", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."team" AS "team", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM "country" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country_id" = "RHS"."country"))) WHERE ("capital" = 'Dublin') ORDER BY POSITION, "position" NULLS LAST;

/*
Gold Result:
('minute',)
('skin',)
('usually',)
*/

-- Prediction Query
SELECT DISTINCT T2.Position FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id = T2.Country WHERE T1.Capital = 'Dublin';

/*
Prediction Result:
('usually',)
('skin',)
('minute',)
*/