-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (0, NULL), (1, 'default2'), (2, 'default1'), (3, NULL);
INSERT INTO player (player_id, team, player, years_played, total_wl, singles_wl, doubles_wl) VALUES (0, 0, 'default1', 'default1', 'default2', 'default2', NULL), (1, 3, 'default1', 'default2', 'default2', 'default1', NULL), (2, 3, NULL, 'default1', NULL, 'default1', NULL), (3, 0, 'default2', 'default2', 'default1', 'default1', 'default1');
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (1, NULL, 'default2', NULL), (0, NULL, 'default2', 'default2'), (2, 'default1', 'default2', 'default1'), (3, 'default1', NULL, 'default1'), (4, 'default2', NULL, 'default1');
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (0.0, 2, 2, 'default1', NULL, NULL, 'default2', NULL), (1.0, 2, NULL, 'default1', 'default1', NULL, 'default1', 'default1'), (100000.0, NULL, 3, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, player, name FROM (SELECT season, player, POSITION, country, team, draft_pick_number, draft_class, college, name, player_other, years_played, total_wl, singles_wl, doubles_wl, team_other, country AS player_id FROM (SELECT LHS.season AS season, LHS.player AS player, LHS.position AS POSITION, LHS.country AS country, LHS.team AS team, LHS.draft_pick_number AS draft_pick_number, LHS.draft_class AS draft_class, LHS.college AS college, RHS.name AS name, RHS.player AS player_other, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team_other FROM match_season AS LHS INNER JOIN (SELECT LHS.team_id AS team_id, LHS.name AS name, RHS.player_id AS player_id, RHS.player AS player, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team FROM team AS LHS CROSS JOIN player AS RHS) AS RHS ON (LHS.country = RHS.player_id AND LHS.team = RHS.team_id))) ORDER BY season, player NULLS LAST, name NULLS LAST;

/*
Gold Result:
(0.0, 'default1', 'default1')
*/

-- Prediction Query
SELECT T1.Season, T1.Player, T2.Name FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id;

/*
Prediction Result:
(0.0, 'default1', 'default1')
(1.0, 'default1', 'default1')
*/