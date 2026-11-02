-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'USA', 'Washington D.C.', 'English');
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Bulls');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2001.0, 1, 1, 'Player A', 'Guard', 1, '2001', 'Duke');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (1999.0, 1, 1, 'Player B', 'Forward', 2, '1999', 'Duke');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2000.0, 1, 1, 'Player C', 'Guard', 3, '2000', 'Duke');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2002.0, 1, 1, 'Player D', 'Center', 4, '2002', 'UCLA');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2003.0, 1, 1, 'Player E', 'Forward', 5, '2003', 'UNC');
INSERT INTO "match_season" ("Season", "Team", "Country", "Player", "Position", "Draft_Pick_Number", "Draft_Class", "College") VALUES (2004.0, 1, 1, 'Player F', 'Center', 6, '2004', NULL);
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played", "Total_WL", "Singles_WL", "Doubles_WL") VALUES (1, 1, 'Player A', '5', '10-2', '5-1', '5-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "position" FROM "match_season" WHERE ("college" <> 'UCLA' AND "college" = 'Duke') ORDER BY POSITION, match_season.season NULLS LAST;

/*
Gold Result:
('Forward',)
('Guard',)
('Guard',)
*/

-- Prediction Query
SELECT DISTINCT POSITION FROM match_season WHERE College = 'UCLA' OR College = 'Duke';

/*
Prediction Result:
('Guard',)
('Forward',)
('Center',)
*/