-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'Brazil', 'Brasilia', 'Portuguese');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (3, 'Germany', 'Berlin', 'German');
INSERT INTO team (Team_id, Name) VALUES (10, 'Red Hawks');
INSERT INTO team (Team_id, Name) VALUES (20, 'Blue Sharks');
INSERT INTO team (Team_id, Name) VALUES (30, 'Golden Eagles');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (101, 10, 'Alex Smith', '2000-2005', '10-2', '6-1', '4-1');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (102, 20, 'Bruno Silva', '1999-2004', '15-5', '10-3', '5-2');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (103, 30, 'Carl Weber', '2001-2006', '8-8', '4-4', '4-4');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1999.0, 20, 2, 'Bruno Silva', 'Midfielder', 15, '1999', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2000.0, 10, 1, 'Alex Smith', 'Defender', 5, '2000', 'Stanford');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2001.0, 30, 3, 'Carl Weber', 'Forward', 25, '2001', 'Duke');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2002.0, 10, 2, 'David Lee', 'Forward', 1, '2002', 'UNC');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2003.0, 20, 3, 'Evan Wright', 'Forward', 30, '2003', 'Virginia');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2004.0, 30, 1, 'Frank Hall', 'Defender', 12, '2004', 'Indiana');
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
('Midfielder',)
('Defender',)
('Forward',)
*/