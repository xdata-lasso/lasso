-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'United States', 'Washington', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'Spain', 'Madrid', 'Spanish');
INSERT INTO team (Team_id, Name) VALUES (10, 'Falcons');
INSERT INTO team (Team_id, Name) VALUES (20, 'Titans');
INSERT INTO team (Team_id, Name) VALUES (30, 'Wolves');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2018.0, 10, 1, 'Other Player', 'Forward', 1, '2018', 'Duke');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 10, 'Zoran Novak', '2005–2007', '12–4', '8–2', '4–2');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 20, 'Maya Lin', '2015–2019', '20–5', '15–3', '5–2');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (3, 30, 'Aaron Reed', '2010–2012', '7–9', '4–5', '3–4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player, years_played FROM player ORDER BY player, player.player_id NULLS LAST;

/*
Gold Result:
('Aaron Reed', '2010–2012')
('Maya Lin', '2015–2019')
('Zoran Novak', '2005–2007')
*/

-- Prediction Query
SELECT Player, Years_Played FROM player;

/*
Prediction Result:
('Zoran Novak', '2005–2007')
('Maya Lin', '2015–2019')
('Aaron Reed', '2010–2012')
*/