-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, Club_name, Region, Start_year) VALUES (1, 'Alpha Club', 'North', 2000);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (1, 1, 'Coach One', 'M', 1);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (2, 1, 'Coach Two', 'F', 2);
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (1, 'SponsorA', 'Alice', 'F', 'Chicago', 'Artist', 10, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (2, 'SponsorB', 'Bob', 'M', 'Chicago', 'Artist', 20, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (3, 'SponsorC', 'Charlie', 'M', 'Austin', 'Doctor', 15, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (4, 'SponsorD', 'Diana', 'F', 'Austin', 'Doctor', 25, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (5, 'SponsorE', 'Evan', 'M', 'Austin', 'Engineer', 30, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (6, 'SponsorF', 'Fiona', 'F', 'Austin', 'Engineer', 40, '4');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (7, 'SponsorG', 'SameName', 'F', 'Boston', 'Baker', 50, '5');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (8, 'SponsorG', 'SameName', 'F', 'Boston', 'Baker', 50, '5');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (9, 'SponsorH', 'Hannah', 'F', 'Boston', 'Chef', 60, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (10, 'SponsorI', 'Ian', 'M', 'Denver', 'Lawyer', 10, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (11, 'SponsorJ', 'Julia', 'F', 'Denver', 'Pilot', 20, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (12, 'SponsorK', 'Kevin', 'M', 'Miami', 'Nurse', 10, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (13, 'SponsorL', 'Laura', 'F', 'Miami', 'Nurse', 20, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (14, 'SponsorM', 'Mike', 'M', 'Miami', 'Nurse', 30, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (15, 'SponsorN', 'Nina', 'F', 'Seattle', 'Lawyer', 40, '4');
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (10, 1, 2015);
INSERT INTO player_coach (Player_ID, Coach_ID, Starting_year) VALUES (10, 2, 2016);
INSERT INTO match_result (Rank, Club_ID, Gold, Big_Silver, Small_Silver, Bronze, Points) VALUES (1, 1, 5, 3, 2, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT residence FROM (SELECT occupation, residence, COUNT(*) AS n FROM player GROUP BY occupation, residence) WHERE (n = 2) ORDER BY residence;

/*
Gold Result:
('Austin',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT Residence FROM player GROUP BY Residence HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Austin',)
('Boston',)
('Chicago',)
('Denver',)
('Miami',)
*/