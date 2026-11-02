-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Team DESC vs ordering by COUNT(*) DESC.
-- Team 100 has the highest ID (count 1, Position 'Defender').
-- Team 10 has the highest count (count 3, Position 'Forward').
-- Team 1 has the lowest ID (count 1, Position 'Goalie').
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'USA', 'Washington', 'English');
INSERT INTO team (Team_id, Name) VALUES (1, 'Alpha');
INSERT INTO team (Team_id, Name) VALUES (10, 'Beta');
INSERT INTO team (Team_id, Name) VALUES (100, 'Gamma');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1990.0, 1, 1, 'P1', 'Goalie', 1, '1990', 'C1');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1991.0, 10, 1, 'P2', 'Forward', 2, '1991', 'C2');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1992.0, 10, 1, 'P3', 'Forward', 3, '1992', 'C3');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1993.0, 10, 1, 'P4', 'Forward', 4, '1993', 'C4');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1994.0, 100, 1, 'P5', 'Defender', 5, '1994', 'C5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT * FROM (SELECT * FROM (SELECT POSITION, team, COUNT(*) AS n FROM match_season GROUP BY POSITION, team) ORDER BY team DESC) LIMIT 1);

/*
Gold Result:
('Defender',)
*/

-- Prediction Query
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY COUNT(*) DESC, POSITION NULLS LAST LIMIT 1;

/*
Prediction Result:
('Forward',)
*/