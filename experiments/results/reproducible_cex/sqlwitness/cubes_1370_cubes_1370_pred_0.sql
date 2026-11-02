-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (0, NULL), (1, 'default1'), (2, 'default1'), (3, NULL);
INSERT INTO player (player_id, team, player, years_played, total_wl, singles_wl, doubles_wl) VALUES (0, NULL, NULL, 'default1', 'default2', NULL, 'default2'), (1, 1, 'default2', NULL, NULL, 'default2', NULL), (2, 0, NULL, NULL, 'default1', 'default1', 'default2'), (3, 0, 'default2', 'default2', NULL, 'default1', 'default1'), (4, 0, 'default1', 'default1', 'default1', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player, years_played FROM player ORDER BY player, player.player_id NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, None)
('default1', 'default1')
('default2', None)
('default2', 'default2')
*/

-- Prediction Query
SELECT Player, Years_Played FROM player;

/*
Prediction Result:
(None, 'default1')
('default2', None)
(None, None)
('default2', 'default2')
('default1', 'default1')
*/