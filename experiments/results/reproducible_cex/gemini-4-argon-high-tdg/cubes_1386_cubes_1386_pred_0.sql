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
INSERT INTO team (Team_id, Name) VALUES (1, 'Warriors');
INSERT INTO team (Team_id, Name) VALUES (2, 'Hawks');
INSERT INTO team (Team_id, Name) VALUES (3, 'Bulls');
INSERT INTO team (Team_id, Name) VALUES (4, 'Hawks');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2020.0, 1, 1, 'John Doe', 'Forward', 1, '2020', 'Duke');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2021.0, 1, 2, 'Jane Roe', 'Guard', 2, '2021', 'UNC');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 2, 'Mike Smith', '2018-2020', '10-2', '5-1', '5-1');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 2, 'Alex Brown', '2019-2021', '8-4', '4-2', '4-2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM team ORDER BY name, team.team_id NULLS LAST;

/*
Gold Result:
('Bulls',)
('Hawks',)
('Hawks',)
('Warriors',)
*/

-- Prediction Query
SELECT Name FROM Team;

/*
Prediction Result:
('Warriors',)
('Hawks',)
('Bulls',)
('Hawks',)
*/