-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO team (Team_id, Name) VALUES (1, 'Lions');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2005.0, 1, 1, 'Player A', 'Defender', 2, '2005 Draft', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2003.0, 1, 1, 'Player B', 'Defender', 5, 'Alpha', 'Duke');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2001.0, 1, 1, 'Player C', 'Defender', 5, 'Gamma', 'UNC');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2002.0, 1, 1, 'Player D', 'Defender', 5, 'Beta', 'Stanford');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1999.0, 1, 1, 'Player E', 'Defender', 10, '1999 Draft', 'Virginia');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2000.0, 1, 1, 'Player F', 'Forward', 1, '2000 Draft', 'Indiana');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2004.0, 1, 1, 'Player G', 'Midfielder', 3, '2004 Draft', 'Maryland');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "draft_pick_number", "draft_class" FROM "match_season" WHERE ("position" = 'Defender') ORDER BY draft_pick_number, match_season.season NULLS LAST;

/*
Gold Result:
(2, '2005 Draft')
(5, 'Gamma')
(5, 'Beta')
(5, 'Alpha')
(10, '1999 Draft')
*/

-- Prediction Query
SELECT Draft_Pick_Number, Draft_Class FROM match_season WHERE POSITION = 'Defender';

/*
Prediction Result:
(2, '2005 Draft')
(5, 'Alpha')
(5, 'Gamma')
(5, 'Beta')
(10, '1999 Draft')
*/