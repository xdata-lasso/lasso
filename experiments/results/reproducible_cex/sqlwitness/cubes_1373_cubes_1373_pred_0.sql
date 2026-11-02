-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (0, NULL);
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (1, 'default1', NULL, NULL);
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (0.0, 0, 1, NULL, NULL, 0, 'default1', NULL), (1.0, 0, 1, 'default2', 'default2', 1, NULL, 'default2'), (33333.333333, NULL, NULL, NULL, 'default2', 1, NULL, 'default1'), (66666.666667, 0, NULL, 'default1', 'default1', 0, NULL, NULL), (100000.0, 0, 1, NULL, NULL, 0, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT POSITION FROM match_season ORDER BY POSITION;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT POSITION FROM match_season;

/*
Prediction Result:
(None,)
('default2',)
('default1',)
*/