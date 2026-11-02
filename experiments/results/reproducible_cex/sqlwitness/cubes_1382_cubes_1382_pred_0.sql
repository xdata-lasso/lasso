-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (0, 'Ryley Goldner');
INSERT INTO player (player_id, team, player, years_played, total_wl, singles_wl, doubles_wl) VALUES (1, 0, 'Ryley Goldner', 'default2', NULL, NULL, 'default1'), (0, 0, 'default1', 'default1', 'Ryley Goldner', 'default2', 'default1'), (2, 0, 'default2', 'default2', 'default1', 'default1', 'default1'), (3, NULL, 'default1', 'default1', 'default1', NULL, 'Ryley Goldner'), (4, NULL, 'default1', NULL, 'default1', 'default2', NULL);
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (1, 'default2', 'default1', 'default2'), (0, 'default2', 'default1', 'Ryley Goldner'), (2, 'default1', 'default1', 'default1'), (3, NULL, NULL, NULL), (4, 'default1', NULL, NULL);
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (1.0, 0, 3, NULL, 'default1', 0, 'default2', NULL), (0.0, 0, 1, NULL, NULL, 0, 'default2', 'default1'), (50000.0, NULL, 3, 'default2', 'default2', 1, 'Ryley Goldner', NULL), (100000.0, NULL, 0, 'default1', 'default1', 0, 'Ryley Goldner', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "position" FROM (SELECT "LHS"."team_id" AS "team_id", "LHS"."name" AS "name", "RHS"."season" AS "season", "RHS"."player" AS "player", "RHS"."position" AS "position", "RHS"."country" AS "country", "RHS"."draft_pick_number" AS "draft_pick_number", "RHS"."draft_class" AS "draft_class", "RHS"."college" AS "college" FROM (SELECT * FROM "team" WHERE ("name" = 'Ryley Goldner')) AS LHS INNER JOIN match_season AS RHS ON (LHS.team_id = RHS.team)) ORDER BY POSITION, "position" NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT T1.Position FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id WHERE T2.Name = 'Ryley Goldner';

/*
Prediction Result:
('default1',)
(None,)
*/