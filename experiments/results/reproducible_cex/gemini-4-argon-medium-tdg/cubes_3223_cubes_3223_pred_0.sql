-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in Player_name and Player_ID (kills NULLS LAST on player_name vs player_id, and tests NULLs in INTEGER PRIMARY KEY).
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (10, 'S1', 'Zack', 'M', 'R1', 'O1', 10, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (20, 'S2', NULL, 'F', 'R2', 'O2', 20, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (NULL, 'S3', 'Aaron', 'M', 'R3', 'O3', 30, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (5, 'S4', 'Aaron', 'F', 'R4', 'O4', 40, '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_name FROM player ORDER BY player_name, player.player_id NULLS LAST;

/*
Gold Result:
(None,)
('Aaron',)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT Player_name FROM player ORDER BY Votes ASC, player.player_id NULLS LAST;

/*
Prediction Result:
('Zack',)
(None,)
('Aaron',)
('Aaron',)
*/