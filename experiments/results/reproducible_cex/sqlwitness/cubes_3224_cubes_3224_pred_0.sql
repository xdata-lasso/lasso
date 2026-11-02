-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO club (club_id, club_name, region, start_year) VALUES (0, 'default1', 'default2', 1), (1, 'default1', NULL, 0);
INSERT INTO player (player_id, sponsor_name, player_name, gender, residence, occupation, votes, rank) VALUES (0, 'default2', 'default1', 'default2', NULL, 'default2', 0, NULL), (2, 'default1', NULL, NULL, 'default2', 'default1', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_name FROM (SELECT * FROM player AS LHS WHERE NOT EXISTS(SELECT 1 FROM player_coach AS RHS WHERE (LHS.player_id = RHS.player_id))) ORDER BY player_name;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT Player_name FROM player WHERE NOT Player_ID IN (SELECT Player_ID FROM player_coach);

/*
Prediction Result:
('default1',)
(None,)
*/