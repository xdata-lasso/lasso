-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (team_id, name) VALUES (1, 'default2');
INSERT INTO country (country_id, country_name, capital, official_native_language) VALUES (2, NULL, 'default1', NULL), (4, NULL, 'default1', NULL), (3, 'default2', 'default2', 'default2');
INSERT INTO match_season (season, team, country, player, position, draft_pick_number, draft_class, college) VALUES (2.0, NULL, 4, NULL, 'default2', 1, NULL, 'default1'), (3.0, NULL, NULL, 'default1', 'default1', 1, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT college_other AS college FROM (SELECT LHS.college AS college, LHS.n AS n, RHS.college AS college_other, RHS.n AS n_other FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS LHS CROSS JOIN (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) AS RHS) WHERE (n < n_other) ORDER BY college;

/*
Gold Result:
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 3;

/*
Prediction Result:
('default1',)
('default2',)
*/