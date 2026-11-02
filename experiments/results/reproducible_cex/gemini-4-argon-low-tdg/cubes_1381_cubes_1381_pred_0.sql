-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty country table (tests difference between window function COUNT(*) OVER () returning 0 rows vs scalar aggregate COUNT(*) returning [0], as well as querying wrong tables)
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Alpha');
INSERT INTO "team" ("Team_id", "Name") VALUES (2, 'Beta');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (1, 1, 'John Doe', '2018-2020', '10-5', '5-3', '5-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM country ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM country;

/*
Prediction Result:
(0,)
*/