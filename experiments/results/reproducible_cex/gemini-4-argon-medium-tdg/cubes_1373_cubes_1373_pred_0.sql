-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO team (Team_id, Name) VALUES (1, 'Warriors');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2001.0, 1, 1, 'Player A', 'Forward', 1, '2001', 'Duke');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2002.0, 1, 1, 'Player B', 'Defender', 2, '2002', 'UNC');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2003.0, 1, 1, 'Player C', 'Forward', 3, '2003', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2004.0, 1, 1, 'Player D', 'Midfielder', 4, '2004', 'Kentucky');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT POSITION FROM match_season ORDER BY POSITION;

/*
Gold Result:
('Defender',)
('Forward',)
('Midfielder',)
*/

-- Prediction Query
SELECT DISTINCT POSITION FROM match_season;

/*
Prediction Result:
('Forward',)
('Defender',)
('Midfielder',)
*/