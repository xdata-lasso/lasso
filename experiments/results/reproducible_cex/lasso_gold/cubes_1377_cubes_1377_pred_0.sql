-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1010, 'Congo', 'sense', 'rate');
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (1014, 'Senegal', 'sure', 'collection');
INSERT INTO "team" ("team_id", "name") VALUES (1011, 'Jennifer Cole');
INSERT INTO "team" ("team_id", "name") VALUES (1015, 'Gina Moore');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1012.5, 1011, 1010, 'husband', 'great', 1013, 'blue', 'according');
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1016.5, 1015, 1014, 'fall', 'table', 1014, 'true', 'best');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player FROM match_season ORDER BY player, match_season.season NULLS LAST;

/*
Gold Result:
('fall',)
('husband',)
*/

-- Prediction Query
SELECT player FROM match_season ORDER BY College ASC, match_season.season NULLS LAST;

/*
Prediction Result:
('husband',)
('fall',)
*/