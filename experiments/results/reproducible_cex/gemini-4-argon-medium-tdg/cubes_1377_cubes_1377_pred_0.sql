-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'USA', 'Washington D.C.', 'English');
INSERT INTO team (Team_id, Name) VALUES (1, 'Hawks');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2022.0, 1, 1, 'Charlie', 'Forward', 10, '2022', 'Duke');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2021.0, 1, 1, 'Alice', 'Guard', 5, '2021', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2019.0, 1, 1, 'Alice', 'Guard', 5, '2019', 'UCLA');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2020.0, 1, 1, 'Bob', 'Center', 1, '2020', 'UNC');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 1, 'Zack', '2018-2022', '10-2', '5-1', '5-1');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 1, 'Yasmine', '2019-2021', '8-4', '4-2', '4-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player FROM match_season ORDER BY player, match_season.season NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT player FROM match_season ORDER BY College ASC, match_season.season NULLS LAST;

/*
Prediction Result:
('Charlie',)
('Alice',)
('Alice',)
('Bob',)
*/