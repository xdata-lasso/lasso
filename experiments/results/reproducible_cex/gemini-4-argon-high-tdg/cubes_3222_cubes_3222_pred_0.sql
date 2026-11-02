-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, Club_name, Region, Start_year) VALUES (1, 'Alpha Club', 'North', 1995);
INSERT INTO club (Club_ID, Club_name, Region, Start_year) VALUES (2, 'Beta Club', 'South', 2005);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (101, 1, 'Coach Smith', 'M', 1);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (102, 2, 'Coach Jones', 'F', 2);
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (1, 'Nike', 'John Doe', 'M', 'New York', 'Teacher', 500, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (2, 'Adidas', 'Alice Wang', 'F', 'Boston', 'Doctor', 300, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (3, 'Puma', 'Bob Ross', 'M', 'Chicago', 'Lawyer', 100, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (4, 'Reebok', 'Clara Oswald', 'F', 'Austin', 'Artist', 150, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (5, 'UnderArmour', 'David Kim', 'M', 'Seattle', 'Teacher', 400, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (6, 'Asics', 'Beth Green', 'F', 'Denver', 'Engineer', 200, '1');
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (1, 101, 2018);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (1, 102, 2020);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (2, 101, 2019);
INSERT INTO match_result (Rank, Club_ID, Gold, Big_Silver, Small_Silver, Bronze, Points) VALUES (1, 1, 5, 3, 2, 1, 100);
INSERT INTO match_result (Rank, Club_ID, Gold, Big_Silver, Small_Silver, Bronze, Points) VALUES (2, 2, 2, 4, 3, 5, 75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gender, occupation FROM player ORDER BY gender, player.player_id NULLS LAST;

/*
Gold Result:
('F', 'Doctor')
('F', 'Artist')
('F', 'Engineer')
('M', 'Teacher')
('M', 'Lawyer')
('M', 'Teacher')
*/

-- Prediction Query
SELECT Gender, Occupation FROM player;

/*
Prediction Result:
('M', 'Teacher')
('F', 'Doctor')
('M', 'Lawyer')
('F', 'Artist')
('M', 'Teacher')
('F', 'Engineer')
*/