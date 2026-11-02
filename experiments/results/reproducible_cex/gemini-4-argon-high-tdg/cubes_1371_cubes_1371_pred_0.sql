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
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (3, 'Spain', 'Madrid', 'Spanish');
INSERT INTO team (Team_id, Name) VALUES (10, 'Alpha');
INSERT INTO team (Team_id, Name) VALUES (20, 'Beta');
INSERT INTO team (Team_id, Name) VALUES (30, 'Gamma');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1.0, 10, 1, 'Adam', 'Guard', 1, '2015', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2.0, 10, 1, 'Brian', 'Forward', 2, '2016', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (3.0, 20, 2, 'Mike', 'Center', 10, '2017', 'Duke');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (4.0, 20, 2, 'Nick', 'Guard', 11, '2018', 'Duke');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (5.0, 30, 3, 'Zack', 'Forward', 20, '2019', 'Auburn');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (6.0, 30, 3, 'Yuri', 'Center', 21, '2020', 'Auburn');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (7.0, 10, 1, 'Carl', 'Guard', 5, '2015', 'Stanford');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (8.0, 20, 2, 'Dave', 'Forward', 6, '2016', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (9.0, 20, 2, 'Evan', 'Center', 7, '2017', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (10.0, 20, 2, 'Frank', 'Guard', 8, '2018', 'UCLA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT college, COUNT(*) AS n FROM match_season GROUP BY college) WHERE (n = 2) ORDER BY college;

/*
Gold Result:
('Auburn',)
('Duke',)
('Yale',)
*/

-- Prediction Query
SELECT College FROM match_season GROUP BY College HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Auburn',)
('Duke',)
('UCLA',)
('Yale',)
*/