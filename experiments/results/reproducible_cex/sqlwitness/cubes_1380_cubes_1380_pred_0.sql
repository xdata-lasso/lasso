-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (0, 'default1'), (1, 'Duke'), (2, 'default2');
INSERT INTO player (player_id, team, player, years_played, total_wl, singles_wl, doubles_wl) VALUES (0, 0, 'Maryland', 'Maryland', NULL, NULL, 'Maryland'), (1, 1, 'Maryland', 'Maryland', NULL, 'Duke', 'default1'), (2, 2, 'default2', NULL, 'default1', 'Duke', 'default2'), (3, 1, 'default2', 'default2', 'Duke', 'default1', 'default2'), (4, 2, 'default1', NULL, NULL, 'Maryland', 'default2'), (5, 1, NULL, 'Maryland', 'Maryland', 'Maryland', 'Duke'), (6, NULL, 'default2', 'Duke', 'default2', 'Maryland', NULL), (7, NULL, 'default2', 'default1', 'Maryland', 'Maryland', NULL), (8, 2, 'default1', 'default1', NULL, 'default2', 'default2');
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (0, 'default2', 'Maryland', 'default1'), (1, 'default2', NULL, 'Maryland'), (2, 'Maryland', NULL, NULL), (3, 'default2', 'Maryland', 'Duke'), (4, 'default2', 'Duke', 'default1'), (5, 'Maryland', 'default2', 'default1'), (6, 'Duke', 'Duke', 'Duke'), (7, 'default1', 'default2', 'default1'), (8, 'default1', 'default1', 'default2'), (9, NULL, 'default2', NULL), (10, 'default1', 'default1', 'Maryland');
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (0.0, 0, 5, 'Maryland', NULL, 0, 'Duke', 'Duke'), (1.0, NULL, 1, 'Duke', NULL, NULL, 'Maryland', 'Maryland'), (50000.0, 2, 10, 'Duke', 'default1', 1, 'default2', 'Maryland'), (100000.0, 2, 10, NULL, NULL, 1, 'default1', 'Duke');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "official_native_language" FROM (SELECT "country_id", "country_name", "capital", "official_native_language", "season", "player", "position", "team", "draft_pick_number", "draft_class", "college", "country_id" AS "country" FROM (SELECT "LHS"."country_id" AS "country_id", "LHS"."country_name" AS "country_name", "LHS"."capital" AS "capital", "LHS"."official_native_language" AS "official_native_language", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."team" AS "team", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM "country" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country_id" = "RHS"."country"))) WHERE ("college" = 'Maryland' OR "college" = 'Duke') ORDER BY official_native_language, "official_native_language" NULLS LAST;

/*
Gold Result:
('Maryland',)
('Maryland',)
('Maryland',)
('default1',)
*/

-- Prediction Query
SELECT T1.Official_native_language FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id = T2.Country WHERE T2.College = 'Maryland' OR T2.College = 'Duke';

/*
Prediction Result:
('default1',)
('Maryland',)
('Maryland',)
('Maryland',)
*/