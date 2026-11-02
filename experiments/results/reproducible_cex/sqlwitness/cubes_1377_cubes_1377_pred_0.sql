-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (1, 'default1'), (0, 'default1'), (2, NULL);
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (0, 'default2', 'default1', NULL), (1, 'default2', NULL, NULL), (2, NULL, NULL, 'default2'), (3, 'default1', 'default1', 'default1');
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (0.0, NULL, 0, 'default2', 'default2', 1, 'default2', NULL), (1.0, 2, 1, 'default2', 'default1', NULL, NULL, 'default1'), (100000.0, NULL, 1, NULL, NULL, NULL, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player FROM match_season ORDER BY player, match_season.season NULLS LAST;

/*
Gold Result:
(None,)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT player FROM match_season ORDER BY College ASC, match_season.season NULLS LAST;

/*
Prediction Result:
('default2',)
('default2',)
(None,)
*/