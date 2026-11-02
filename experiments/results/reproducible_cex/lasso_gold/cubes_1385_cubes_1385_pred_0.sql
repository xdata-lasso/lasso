-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1054, 'Monaco', 'nothing', 'everyone');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1058, 'Malawi', 'minute', 'benefit');
INSERT INTO "team" ("team_id", "name") VALUES (1055, 'Jessica Silva');
INSERT INTO "team" ("team_id", "name") VALUES (1059, 'Shannon Hernandez');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1056.5, 1055, 1054, 'collection', 'Defender', 1058, 'discuss', 'certainly');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1060.5, 1059, 1058, 'high', 'Defender', 1057, 'structure', 'response');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "draft_pick_number", "draft_class" FROM "match_season" WHERE ("position" = 'Defender') ORDER BY draft_pick_number, match_season.season NULLS LAST;

/*
Gold Result:
(1057, 'structure')
(1058, 'discuss')
*/

-- Prediction Query
SELECT Draft_Pick_Number, Draft_Class FROM match_season WHERE POSITION = 'Defender';

/*
Prediction Result:
(1058, 'discuss')
(1057, 'structure')
*/