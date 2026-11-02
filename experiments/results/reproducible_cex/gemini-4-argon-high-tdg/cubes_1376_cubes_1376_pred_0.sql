-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'Canada', 'Ottawa', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (3, 'Brazil', 'Brasilia', 'Portuguese');
INSERT INTO team (Team_id, Name) VALUES (10, 'Zeta Club');
INSERT INTO team (Team_id, Name) VALUES (15, 'Beta Squad');
INSERT INTO team (Team_id, Name) VALUES (20, 'Omega United');
INSERT INTO team (Team_id, Name) VALUES (25, 'Apex Rovers');
INSERT INTO team (Team_id, Name) VALUES (30, 'Alpha Athletic');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2001.0, 10, 3, 'P1', 'Striker', 50, '2001', 'Duke');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2002.0, 10, 3, 'P2', 'Striker', 40, '2002', 'UNC');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2003.0, 15, 2, 'P3', 'Midfielder', 10, '2003', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2004.0, 15, 2, 'P4', 'Midfielder', 11, '2004', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2005.0, 15, 2, 'P5', 'Midfielder', 12, '2005', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2006.0, 15, 2, 'P6', 'Midfielder', 13, '2006', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2007.0, 15, 2, 'P7', 'Midfielder', 14, '2007', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2008.0, 10, 1, 'P8', 'Forward', 20, '2008', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2009.0, 10, 1, 'P9', 'Forward', 21, '2009', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2010.0, 10, 1, 'P10', 'Forward', 22, '2010', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2011.0, 20, 1, 'P11', 'Forward', 23, '2011', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2012.0, 20, 1, 'P12', 'Forward', 24, '2012', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2013.0, 20, 1, 'P13', 'Forward', 25, '2013', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1990.0, 25, 1, 'P14', 'Back', 1, '1990', 'Stanford');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2000.0, 30, 2, 'P15', 'Center', 5, '2000', 'Michigan');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2000.5, 30, 2, 'P16', 'Center', 6, '2000', 'Michigan');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 10, 'P1', '2001-2005', '10-2', '5-1', '5-1');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 15, 'P3', '2003-2007', '20-5', '10-2', '10-3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT * FROM (SELECT * FROM (SELECT POSITION, team, COUNT(*) AS n FROM match_season GROUP BY POSITION, team) ORDER BY team DESC) LIMIT 1);

/*
Gold Result:
('Center',)
*/

-- Prediction Query
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY COUNT(*) DESC, POSITION NULLS LAST LIMIT 1;

/*
Prediction Result:
('Forward',)
*/