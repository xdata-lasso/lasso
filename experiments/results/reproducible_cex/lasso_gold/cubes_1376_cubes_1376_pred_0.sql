-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1017, 'Guadeloupe', 'bill', 'PM');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1018, 'Bosnia and Herzegovina', 'her', 'everything');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1019, 'Bermuda', 'throw', 'surface');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1020, 'Hong Kong', 'guy', 'animal');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1066, 'Saint Helena', 'social', 'brother');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1067, 'Brazil', 'specific', 'finally');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1068, 'Pitcairn Islands', 'put', 'learn');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1069, 'Mauritania', 'grow', 'coach');
INSERT INTO "team" ("team_id", "name") VALUES (1021, 'Kimberly Dudley');
INSERT INTO "team" ("team_id", "name") VALUES (1022, 'Juan Calderon');
INSERT INTO "team" ("team_id", "name") VALUES (1023, 'Shannon Ray');
INSERT INTO "team" ("team_id", "name") VALUES (1024, 'Amber Perez');
INSERT INTO "team" ("team_id", "name") VALUES (1070, 'Troy Liu');
INSERT INTO "team" ("team_id", "name") VALUES (1071, 'Jonathan White');
INSERT INTO "team" ("team_id", "name") VALUES (1072, 'Sheila Evans');
INSERT INTO "team" ("team_id", "name") VALUES (1073, 'Lisa Hernandez');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1025.5, 1021, 1017, 'figure', 'trial', 1029, 'blood', 'prove');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1026.5, 1021, 1017, 'base', 'trial', 1042.0, 'husband', 'they');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1027.5, 1021, 1017, 'top', 'trial', 1055.0, 'fall', 'his');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1028.5, 1021, 1017, 'early', 'trial', 1068.0, 'long', 'commercial');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1074.5, 1070, NULL, 'sound', 'win', 1078, 'nice', 'game');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1075.5, 1070, NULL, 'color', 'win', 1091.0, 'why', 'middle');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1076.5, 1070, NULL, 'notice', 'win', 1104.0, 'a', 'after');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1077.5, 1070, NULL, 'start', 'win', 1117.0, 'place', 'woman');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT * FROM (SELECT * FROM (SELECT POSITION, team, COUNT(*) AS n FROM match_season GROUP BY POSITION, team) ORDER BY team DESC) LIMIT 1);

/*
Gold Result:
('win',)
*/

-- Prediction Query
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY COUNT(*) DESC, POSITION NULLS LAST LIMIT 1;

/*
Prediction Result:
('trial',)
*/