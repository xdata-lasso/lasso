-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: team --
INSERT INTO "team" ("team_id", "name") VALUES (1, 't2__878cf9');

INSERT INTO "team" ("team_id", "name") VALUES (3, 't2__878cf9');

INSERT INTO "team" ("team_id", "name") VALUES (2, 'tti');

-- Inserting into table: country --
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4');

-- Inserting into table: match_season --
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1.0, 1, -2147483648, 't1__439fe8', 'gu7v', -1865039888, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (2.0, 1, -2147483648, 't1__439fe8', 'rmdp', 2026480202, 'ie5', 'nw6klf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, player, name FROM (SELECT season, player, POSITION, country, team, draft_pick_number, draft_class, college, name, player_other, years_played, total_wl, singles_wl, doubles_wl, team_other, country AS player_id FROM (SELECT LHS.season AS season, LHS.player AS player, LHS.position AS POSITION, LHS.country AS country, LHS.team AS team, LHS.draft_pick_number AS draft_pick_number, LHS.draft_class AS draft_class, LHS.college AS college, RHS.name AS name, RHS.player AS player_other, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team_other FROM match_season AS LHS INNER JOIN (SELECT LHS.team_id AS team_id, LHS.name AS name, RHS.player_id AS player_id, RHS.player AS player, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team FROM team AS LHS CROSS JOIN player AS RHS) AS RHS ON (LHS.country = RHS.player_id AND LHS.team = RHS.team_id))) ORDER BY season, player NULLS LAST, name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Season, T1.Player, T2.Name FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id;

/*
Prediction Result:
(1.0, 't1__439fe8', 't2__878cf9')
(2.0, 't1__439fe8', 't2__878cf9')
*/