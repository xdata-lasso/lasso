-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO player (player_id, team, player, years_played, total_wl, singles_wl, doubles_wl) VALUES (1, NULL, 'default2', 'default1', 'UCLA', 'UCLA', 'default1'), (0, NULL, 'default1', 'UCLA', 'default1', 'UCLA', 'default2'), (2, NULL, 'default2', NULL, 'default1', NULL, 'UCLA'), (3, NULL, 'default2', 'UCLA', 'default1', 'default2', 'default1'), (4, NULL, 'UCLA', NULL, 'UCLA', 'UCLA', 'default1');
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (1, 'default2', 'default2', 'UCLA'), (0, 'default1', 'default1', NULL), (2, NULL, 'default2', 'default1'), (3, 'UCLA', 'default1', 'default2'), (4, 'default2', NULL, NULL), (5, 'UCLA', 'UCLA', 'UCLA');
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (0.0, NULL, 4, 'default1', NULL, 0, 'default2', 'UCLA'), (1.0, NULL, 4, 'UCLA', 'default2', 1, 'UCLA', 'default1'), (16666.666667, NULL, 2, 'UCLA', 'default2', NULL, 'default2', 'UCLA'), (33333.333333, NULL, 3, NULL, 'UCLA', 0, 'default2', 'UCLA'), (50000.0, NULL, 5, NULL, NULL, 0, NULL, 'default2'), (66666.666667, NULL, 3, 'default1', 'default2', NULL, 'UCLA', 'default1'), (83333.333333, NULL, 2, 'default2', NULL, NULL, NULL, NULL), (100000.0, NULL, NULL, 'UCLA', 'default2', 0, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player" FROM (SELECT "LHS"."season" AS "season", "LHS"."player" AS "player", "LHS"."position" AS "position", "LHS"."country" AS "country", "LHS"."team" AS "team", "LHS"."draft_pick_number" AS "draft_pick_number", "LHS"."draft_class" AS "draft_class", "LHS"."college" AS "college", "RHS"."player_id" AS "player_id", "RHS"."years_played" AS "years_played", "RHS"."total_wl" AS "total_wl", "RHS"."singles_wl" AS "singles_wl", "RHS"."doubles_wl" AS "doubles_wl" FROM (SELECT * FROM "match_season" WHERE ("college" = 'UCLA')) AS LHS LEFT JOIN player AS RHS ON (LHS.player = RHS.player AND LHS.team = RHS.team)) ORDER BY player, "player" NULLS LAST;

/*
Gold Result:
(None,)
('UCLA',)
('default1',)
*/

-- Prediction Query
SELECT Player FROM match_season WHERE College = 'UCLA';

/*
Prediction Result:
('default1',)
('UCLA',)
(None,)
*/