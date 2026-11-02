-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO club (Club_ID, Club_name, Region, Start_year) VALUES (1, 'Metro Club', 'East', 2000);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (1, 1, 'Coach Smith', 'M', 1);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (2, 1, 'Coach Jones', 'F', 2);
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (1, 'Sony', 'Zoe', 'F', 'Miami', 'Artist', 500, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (2, 'LG', 'Liam', 'M', 'Dallas', 'Chef', 200, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (3, 'Samsung', 'Aaron', 'M', 'Denver', 'Pilot', 500, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (4, 'Intel', 'Mia', 'F', 'Austin', 'Writer', 500, '4');
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (2, 1, 2015);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (3, 1, 2016);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (3, 2, 2017);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_name FROM (SELECT LHS.player_id AS player_id, LHS.sponsor_name AS sponsor_name, LHS.player_name AS player_name, LHS.gender AS gender, LHS.residence AS residence, LHS.occupation AS occupation, LHS.votes AS votes, LHS.rank AS rank FROM player AS LHS INNER JOIN (SELECT player_id, sponsor_name, player_name, gender, residence, occupation, MAX(votes) OVER () AS votes, rank FROM player) AS RHS ON (LHS.player_id = RHS.player_id AND LHS.sponsor_name = RHS.sponsor_name AND LHS.player_name = RHS.player_name AND LHS.gender = RHS.gender AND LHS.residence = RHS.residence AND LHS.occupation = RHS.occupation AND LHS.votes = RHS.votes AND LHS.rank = RHS.rank)) ORDER BY player_name;

/*
Gold Result:
('Aaron',)
('Mia',)
('Zoe',)
*/

-- Prediction Query
SELECT Player_name FROM player ORDER BY Votes DESC, player.player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zoe',)
*/