-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, Club_name, Region, Start_year) VALUES (1, 'Club A', 'North', 2000);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (1, 1, 'Coach X', 'M', 1);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (2, 1, 'Coach Y', 'F', 2);
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (1, 'Sponsor Z', 'Zara', 'F', 'NY', 'Student', 100, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (2, 'Sponsor A', 'Bob', 'M', 'LA', 'Engineer', 200, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (3, 'Sponsor M', 'Alice', 'F', 'SF', 'Doctor', 150, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (4, 'Sponsor B', 'Charlie', 'M', 'TX', 'Artist', 300, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (5, 'Sponsor C', 'David', 'M', 'FL', 'Pilot', 50, '4');
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (4, 1, 2018);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (4, 2, 2019);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (5, 1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_name FROM (SELECT * FROM player AS LHS WHERE NOT EXISTS(SELECT 1 FROM player_coach AS RHS WHERE (LHS.player_id = RHS.player_id))) ORDER BY player_name;

/*
Gold Result:
('Alice',)
('Bob',)
('Zara',)
*/

-- Prediction Query
SELECT Player_name FROM player WHERE NOT Player_ID IN (SELECT Player_ID FROM player_coach);

/*
Prediction Result:
('Zara',)
('Bob',)
('Alice',)
*/