-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1017, 'Cape Verde', 'blue', 'her');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1018, 'Cuba', 'best', 'throw');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1019, 'Serbia', 'husband', 'guy');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1020, 'Guadeloupe', 'bill', 'PM');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1033, 'Korea', 'commercial', 'religious');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1034, 'North Macedonia', 'hospital', 'example');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1035, 'Syrian Arab Republic', 'hear', 'science');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1036, 'Haiti', 'determine', 'write');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1049, 'United States Minor Outlying Islands', 'serious', 'money');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1050, 'Western Sahara', 'forward', 'individual');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1051, 'Montenegro', 'difference', 'usually');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1052, 'Turkey', 'reality', 'who');
INSERT INTO "team" ("team_id", "name") VALUES (1021, 'Andrew Stevens');
INSERT INTO "team" ("team_id", "name") VALUES (1022, 'Thomas Miller');
INSERT INTO "team" ("team_id", "name") VALUES (1023, 'Mark Mcclure');
INSERT INTO "team" ("team_id", "name") VALUES (1024, 'Corey Jones');
INSERT INTO "team" ("team_id", "name") VALUES (1037, 'Andrea Reid');
INSERT INTO "team" ("team_id", "name") VALUES (1038, 'Danielle Ford');
INSERT INTO "team" ("team_id", "name") VALUES (1039, 'Timothy Watts');
INSERT INTO "team" ("team_id", "name") VALUES (1040, 'Frederick Tate');
INSERT INTO "team" ("team_id", "name") VALUES (1053, 'Brenda Taylor');
INSERT INTO "team" ("team_id", "name") VALUES (1054, 'Kimberly Burgess');
INSERT INTO "team" ("team_id", "name") VALUES (1055, 'Kevin Cox');
INSERT INTO "team" ("team_id", "name") VALUES (1056, 'Brenda Snyder PhD');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1025.5, 1021, 1017, 'recently', 'base', 1029, 'top', 'fall');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1026.5, 1021, 1017, 'drive', 'base', 1042.0, 'early', 'fall');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1027.5, 1021, 1017, 'spring', 'base', 1055.0, 'trial', 'fall');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1028.5, 1021, 1017, 'figure', 'base', 1068.0, 'blood', 'fall');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1041.5, NULL, 1033, 'arrive', 'support', 1045, 'four', 'development');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1042.5, NULL, 1033, 'drop', 'support', 1058.0, 'institution', 'development');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1043.5, NULL, 1033, 'term', 'support', 1071.0, 'executive', 'development');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1044.5, NULL, 1033, 'almost', 'support', 1084.0, 'attorney', 'development');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1057.5, 1053, 1049, 'traditional', 'support', 1061, 'collection', 'development');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1058.5, 1053, 1049, 'break', 'support', 1074.0, 'structure', 'development');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1059.5, 1053, 1049, 'claim', 'support', 1087.0, 'response', 'development');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1060.5, 1053, 1049, 'product', 'support', 1100.0, 'knowledge', 'development');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1065.5, NULL, 1017, 'recently', 'base', 1029, 'top', 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT * FROM (SELECT * FROM (SELECT college, POSITION, MAX(n) AS n FROM (SELECT season, player, POSITION, country, team, draft_pick_number, draft_class, college, COUNT(*) OVER () AS n FROM match_season) GROUP BY college, POSITION) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('base',)
*/

-- Prediction Query
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY COUNT(*) DESC, POSITION NULLS LAST LIMIT 1;

/*
Prediction Result:
('support',)
*/