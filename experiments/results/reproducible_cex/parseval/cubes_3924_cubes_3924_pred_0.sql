-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: team --
INSERT INTO "team" ("team_id", "name") VALUES (1, '5k5swwqcgs');

-- Inserting into table: country --
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1, '9n8', '4', 'gu7v');

-- Inserting into table: match_season --
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1.0, 1, 1, 'mat_2761de', 'mat_dc7651', 1, 'mat_be2bee', 'mat_921549');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (86.520366, 1, 1, 'mat_204687', 'mat_d8ba97', 1, 'mat_077b6a', 'mat_669ee9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT * FROM (SELECT * FROM (SELECT college, POSITION, MAX(n) AS n FROM (SELECT season, player, POSITION, country, team, draft_pick_number, draft_class, college, COUNT(*) OVER () AS n FROM match_season) GROUP BY college, POSITION) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('mat_dc7651',)
*/

-- Prediction Query
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY COUNT(*) DESC, POSITION NULLS LAST LIMIT 1;

/*
Prediction Result:
('mat_d8ba97',)
*/