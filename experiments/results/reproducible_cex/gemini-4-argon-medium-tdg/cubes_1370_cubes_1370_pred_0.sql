-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO team (Team_id, Name) VALUES (1, 'Lakers');
INSERT INTO team (Team_id, Name) VALUES (2, 'Bulls');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (10, 1, 'Zack', '2010-2015', '10-2', '5-1', '5-1');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (20, 2, 'Adam', '2005-2009', '8-4', '4-2', '4-2');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (30, NULL, 'Mike', '2018-2022', '12-0', '6-0', '6-0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player, years_played FROM player ORDER BY player, player.player_id NULLS LAST;

/*
Gold Result:
('Adam', '2005-2009')
('Mike', '2018-2022')
('Zack', '2010-2015')
*/

-- Prediction Query
SELECT Player, Years_Played FROM player;

/*
Prediction Result:
('Zack', '2010-2015')
('Adam', '2005-2009')
('Mike', '2018-2022')
*/