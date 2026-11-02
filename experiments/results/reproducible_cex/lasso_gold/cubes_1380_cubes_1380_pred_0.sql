-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1053, 'Turks and Caicos Islands', 'who', 'question');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1061, 'Ukraine', 'past', 'inside');
INSERT INTO "team" ("team_id", "name") VALUES (1054, 'Derek Wright');
INSERT INTO "team" ("team_id", "name") VALUES (1062, 'Zachary Taylor');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1055.5, 1054, 1053, 'option', 'everyone', 1059, 'pattern', 'Maryland');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1056.5, 1054, 1053, 'nothing', 'skin', 1072.0, 'later', 'Duke');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1063.5, 1062, 1061, 'minute', 'someone', 1067, 'traditional', 'Maryland');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1064.5, 1062, 1061, 'benefit', 'anyone', 1080.0, 'break', 'Duke');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "official_native_language" FROM (SELECT "country_id", "country_name", "capital", "official_native_language", "season", "player", "position", "team", "draft_pick_number", "draft_class", "college", "country_id" AS "country" FROM (SELECT "LHS"."country_id" AS "country_id", "LHS"."country_name" AS "country_name", "LHS"."capital" AS "capital", "LHS"."official_native_language" AS "official_native_language", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."team" AS "team", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM "country" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country_id" = "RHS"."country"))) WHERE ("college" = 'Maryland' OR "college" = 'Duke') ORDER BY official_native_language, "official_native_language" NULLS LAST;

/*
Gold Result:
('inside',)
('inside',)
('question',)
('question',)
*/

-- Prediction Query
SELECT T1.Official_native_language FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id = T2.Country WHERE T2.College = 'Maryland' OR T2.College = 'Duke';

/*
Prediction Result:
('question',)
('question',)
('inside',)
('inside',)
*/