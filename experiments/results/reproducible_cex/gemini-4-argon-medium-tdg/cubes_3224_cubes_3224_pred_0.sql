-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join, ordering of results, duplicate player names (SELECT vs SELECT DISTINCT),
-- and confuses Player_ID with Coach_ID or other attributes.
INSERT INTO club (Club_ID, Club_name, Region, Start_year) VALUES (10, 'Alpha Club', 'North', 1995);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (1, 10, 'Coach A', 'M', 1);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (2, 10, 'Coach B', 'F', 2);
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (1, 'Sponsor X', 'Zack', 'M', 'NY', 'Student', 100, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (2, 'Sponsor Y', 'Alice', 'F', 'LA', 'Engineer', 200, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (3, 'Sponsor Z', 'Alice', 'M', 'SF', 'Doctor', 150, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (4, 'Sponsor W', 'Bob', 'M', 'TX', 'Lawyer', 300, '4');
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (4, 1, 2020);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (4, 2, 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_name FROM (SELECT * FROM player AS LHS WHERE NOT EXISTS(SELECT 1 FROM player_coach AS RHS WHERE (LHS.player_id = RHS.player_id))) ORDER BY player_name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Player_name FROM player WHERE NOT Player_ID IN (SELECT Player_ID FROM player_coach);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/