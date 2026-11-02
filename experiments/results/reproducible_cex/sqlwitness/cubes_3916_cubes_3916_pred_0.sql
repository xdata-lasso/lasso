-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (1, 'Dublin'), (0, NULL), (2, 'Dublin'), (3, 'default1'), (4, 'default1'), (5, 'default1'), (6, 'Dublin'), (7, 'Dublin');
INSERT INTO player (player_id, team, player, years_played, total_wl, singles_wl, doubles_wl) VALUES (1, 2, 'default1', NULL, 'Dublin', NULL, NULL), (0, 2, 'default2', NULL, 'default1', 'default2', 'default1'), (2, NULL, 'Dublin', NULL, 'default1', 'default1', NULL), (3, 7, NULL, 'Dublin', 'default1', 'default2', 'default2'), (4, 0, 'default1', 'default2', 'Dublin', 'default2', 'default1'), (5, 0, NULL, 'default2', 'Dublin', 'Dublin', 'Dublin');
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (0, 'Dublin', 'Dublin', 'default1'), (1, 'default1', 'default1', 'default2'), (2, 'default1', NULL, 'default2'), (3, NULL, 'Dublin', NULL), (4, 'default2', 'default1', NULL), (5, 'default1', 'default2', 'Dublin'), (6, 'default1', 'Dublin', NULL);
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (0.0, 1, 0, 'Dublin', 'default2', 1, 'default1', NULL), (1.0, 4, 6, 'default1', 'default2', 1, 'default2', NULL), (11111.111111, 1, 3, 'default2', 'Dublin', 0, 'Dublin', NULL), (22222.222222, 1, 6, 'default2', 'Dublin', 1, 'default2', 'default2'), (33333.333333, 5, 0, 'default2', NULL, 0, 'default2', 'default1'), (44444.444444, 6, 0, 'default1', 'default2', 0, 'default2', NULL), (55555.555556, 2, 4, 'Dublin', 'Dublin', 0, 'default1', 'Dublin'), (66666.666667, 6, 0, 'default1', 'default1', 1, NULL, 'Dublin'), (77777.777778, 4, 4, NULL, NULL, 1, 'default1', 'default1'), (88888.888889, 3, 3, 'Dublin', NULL, NULL, 'Dublin', 'default2'), (100000.0, 6, 3, 'default1', 'Dublin', 0, 'default1', 'Dublin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "position" FROM (SELECT "country_id", "country_name", "capital", "official_native_language", "season", "player", "position", "team", "draft_pick_number", "draft_class", "college", "country_id" AS "country" FROM (SELECT "LHS"."country_id" AS "country_id", "LHS"."country_name" AS "country_name", "LHS"."capital" AS "capital", "LHS"."official_native_language" AS "official_native_language", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."team" AS "team", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM "country" AS "LHS" INNER JOIN "match_season" AS "RHS" ON ("LHS"."country_id" = "RHS"."country"))) WHERE ("capital" = 'Dublin') ORDER BY POSITION, "position" NULLS LAST;

/*
Gold Result:
(None,)
('Dublin',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT T2.Position FROM country AS T1 JOIN match_season AS T2 ON T1.Country_id = T2.Country WHERE T1.Capital = 'Dublin';

/*
Prediction Result:
('default2',)
('Dublin',)
(None,)
('default1',)
*/