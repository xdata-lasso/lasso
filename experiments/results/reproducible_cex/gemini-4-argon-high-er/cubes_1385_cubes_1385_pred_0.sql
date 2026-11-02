-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Team A');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (1.0, 1, 1, 'Player 1', 'Defender', 2, 'Class A', 'College A');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2.0, 1, 1, 'Player 2', 'Defender', 1, 'Class B', 'College B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "draft_pick_number", "draft_class" FROM "match_season" WHERE ("position" = 'Defender') ORDER BY draft_pick_number, match_season.season NULLS LAST;

/*
Gold Result:
(1, 'Class B')
(2, 'Class A')
*/

-- Prediction Query
SELECT Draft_Pick_Number, Draft_Class FROM match_season WHERE POSITION = 'Defender';

/*
Prediction Result:
(2, 'Class A')
(1, 'Class B')
*/