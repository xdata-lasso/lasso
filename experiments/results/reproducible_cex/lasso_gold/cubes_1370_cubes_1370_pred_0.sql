-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "team" ("team_id", "name") VALUES (1006, 'Alyssa Gonzalez');
INSERT INTO "team" ("team_id", "name") VALUES (1008, 'Donald Booth');
INSERT INTO "player" ("player_id", "team", "player", "years_played", "total_wl", "singles_wl", "doubles_wl") VALUES (1007, 1006, 'rate', 'science', 'collection', 'kind', 'discussion');
INSERT INTO "player" ("player_id", "team", "player", "years_played", "total_wl", "singles_wl", "doubles_wl") VALUES (1009, 1008, 'grow', 'sure', 'offer', 'save', 'knowledge');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player, years_played FROM player ORDER BY player, player.player_id NULLS LAST;

/*
Gold Result:
('grow', 'sure')
('rate', 'science')
*/

-- Prediction Query
SELECT Player, Years_Played FROM player;

/*
Prediction Result:
('rate', 'science')
('grow', 'sure')
*/