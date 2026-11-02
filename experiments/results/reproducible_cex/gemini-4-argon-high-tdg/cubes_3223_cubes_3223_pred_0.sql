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
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (10, 1, 'Coach Carter', 'M', 1);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (20, 2, 'Coach Taylor', 'F', 2);
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (1, 'Nike', 'Zack Morris', 'M', 'California', 'Student', 100, '1st');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (2, 'Adidas', 'Alice Smith', 'F', 'New York', 'Engineer', 500, '2nd');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (3, 'Puma', 'Bob Jones', 'M', 'Texas', 'Doctor', 250, '3rd');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (4, 'Reebok', 'Alice Smith', 'F', 'Florida', 'Teacher', 50, '4th');
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (1, 10, 2018);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (1, 20, 2020);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (2, 10, 2019);
INSERT INTO match_result (Rank, Club_ID, Gold, Big_Silver, Small_Silver, Bronze, Points) VALUES (1, 1, 5, 3, 2, 1, 50);
INSERT INTO match_result (Rank, Club_ID, Gold, Big_Silver, Small_Silver, Bronze, Points) VALUES (2, 2, 2, 4, 1, 3, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_name FROM player ORDER BY player_name, player.player_id NULLS LAST;

/*
Gold Result:
('Alice Smith',)
('Alice Smith',)
('Bob Jones',)
('Zack Morris',)
*/

-- Prediction Query
SELECT Player_name FROM player ORDER BY Votes ASC, player.player_id NULLS LAST;

/*
Prediction Result:
('Alice Smith',)
('Zack Morris',)
('Bob Jones',)
('Alice Smith',)
*/