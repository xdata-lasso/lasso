-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (0, NULL), (1, NULL), (2, NULL), (3, 'default1'), (4, NULL), (5, 'default2'), (6, NULL);
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (3.0, 5, NULL, 'default2', 'default2', 2, 'default2', 'default2'), (0.0, 0, NULL, 'default1', 'default2', 3, 'default2', NULL), (1.0, 5, NULL, 'default2', 'default2', 3, NULL, NULL), (2.0, 2, NULL, NULL, 'default1', NULL, 'default1', NULL), (25000.0, 4, NULL, NULL, 'default1', 2, 'default2', 'default2'), (50000.0, 1, NULL, 'default2', 'default1', 0, 'default1', NULL), (75000.0, 3, NULL, 'default1', 'default2', NULL, 'default1', NULL), (100000.0, 5, NULL, 'default2', 'default1', 2, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) WHERE (n = 2) ORDER BY college;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College HAVING COUNT(*) >= 2 ORDER BY College DESC;

/*
Prediction Result:
('default2',)
(None,)
*/