-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (0, 'Defender'), (1, 'Defender'), (2, 'Defender'), (3, 'default1'), (4, 'default1');
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (1, NULL, 'default1', 'Defender'), (0, 'default2', 'default2', 'Defender'), (2, 'default1', 'default2', NULL);
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (1.0, 2, 0, 'Defender', 'Defender', 1, 'default2', 'Defender'), (0.0, 4, 1, 'Defender', 'default2', 1, NULL, 'Defender'), (16666.666667, 1, NULL, 'Defender', 'default2', NULL, 'Defender', NULL), (33333.333333, 0, NULL, 'default1', NULL, 0, 'Defender', 'Defender'), (50000.0, 1, 0, 'default1', 'Defender', NULL, 'default1', NULL), (66666.666667, 1, 2, NULL, 'default2', 1, 'default1', 'default1'), (83333.333333, 1, NULL, 'default2', 'default1', 0, 'default1', 'default1'), (100000.0, 4, NULL, 'default2', 'default2', 0, 'Defender', 'Defender');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "draft_pick_number", "draft_class" FROM "match_season" WHERE ("position" = 'Defender') ORDER BY draft_pick_number, match_season.season NULLS LAST;

/*
Gold Result:
(None, 'default1')
(1, 'default2')
*/

-- Prediction Query
SELECT Draft_Pick_Number, Draft_Class FROM match_season WHERE POSITION = 'Defender';

/*
Prediction Result:
(1, 'default2')
(None, 'default1')
*/