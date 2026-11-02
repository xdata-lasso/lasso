-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO team (Team_id, Name) VALUES (1, 'Team A');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 1, 'B', '2020', '1-0', '1-0', '0-0');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 1, 'A', '2021', '2-0', '2-0', '0-0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player, years_played FROM player ORDER BY player, player.player_id NULLS LAST;

/*
Gold Result:
('A', '2021')
('B', '2020')
*/

-- Prediction Query
SELECT Player, Years_Played FROM player;

/*
Prediction Result:
('B', '2020')
('A', '2021')
*/