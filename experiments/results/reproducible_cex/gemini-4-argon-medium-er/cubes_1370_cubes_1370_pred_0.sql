-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "team" ("Team_id", "Name") VALUES (1, 'Team A');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played") VALUES (1, 1, 'Zack', '2020');
INSERT INTO "player" ("Player_ID", "Team", "Player", "Years_Played") VALUES (2, 1, 'Adam', '2021');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player, years_played FROM player ORDER BY player, player.player_id NULLS LAST;

/*
Gold Result:
('Adam', '2021')
('Zack', '2020')
*/

-- Prediction Query
SELECT Player, Years_Played FROM player;

/*
Prediction Result:
('Zack', '2020')
('Adam', '2021')
*/