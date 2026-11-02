-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: team --
INSERT INTO "team" ("team_id", "name") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: country --
INSERT INTO "country" ("country_id", "country_name", "capital", "official_native_language") VALUES (-2147483648, '9n8', '4', 'gu7v');

-- Inserting into table: match_season --
INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (1.0, -2147483648, -2147483648, 'e4', 'mat_2014b9', 1160656988, 'ia2yp', 'Duke');

INSERT INTO "match_season" ("season", "team", "country", "player", "position", "draft_pick_number", "draft_class", "college") VALUES (3.0, -2147483648, -2147483648, 'rwbbp6luhvd', 'mat_2014b9', -1377057208, 'ilbnp', 'Duke');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "position" FROM "match_season" WHERE ("college" <> 'UCLA' AND "college" = 'Duke') ORDER BY POSITION, match_season.season NULLS LAST;

/*
Gold Result:
('mat_2014b9',)
('mat_2014b9',)
*/

-- Prediction Query
SELECT DISTINCT POSITION FROM match_season WHERE College = 'UCLA' OR College = 'Duke';

/*
Prediction Result:
('mat_2014b9',)
*/