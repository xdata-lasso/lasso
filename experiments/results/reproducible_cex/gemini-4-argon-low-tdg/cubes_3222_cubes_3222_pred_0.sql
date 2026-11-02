-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core dataset: Tests primary sort (gender ASC), secondary tie-breaker sort (player_id ASC),
-- duplicate projection rows (kills SELECT DISTINCT / GROUP BY), and unrelated player_coach links (kills inner/left JOINs).
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (10, 'S1', 'Alice', 'Male', 'CityA', 'Engineer', 100, '1');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (5, 'S2', 'Bob', 'Male', 'CityB', 'Doctor', 200, '2');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (20, 'S3', 'Charlie', 'Female', 'CityC', 'Artist', 50, '3');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (15, 'S4', 'Diana', 'Female', 'CityD', 'Artist', 150, '4');
INSERT INTO "club" ("Club_ID", "Club_name", "Region", "Start_year") VALUES (1, 'ClubA', 'North', 2000);
INSERT INTO "coach" ("Coach_ID", "Club_ID", "Coach_name", "Gender", "Rank") VALUES (1, 1, 'CoachX', 'Male', 1);
INSERT INTO "coach" ("Coach_ID", "Club_ID", "Coach_name", "Gender", "Rank") VALUES (2, 1, 'CoachY', 'Female', 2);
INSERT INTO "player_coach" ("Player_ID", "Coach_ID", "Starting_year") VALUES (10, 1, 2010);
INSERT INTO "player_coach" ("Player_ID", "Coach_ID", "Starting_year") VALUES (10, 2, 2012);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gender, occupation FROM player ORDER BY gender, player.player_id NULLS LAST;

/*
Gold Result:
('Female', 'Artist')
('Female', 'Artist')
('Male', 'Doctor')
('Male', 'Engineer')
*/

-- Prediction Query
SELECT Gender, Occupation FROM player;

/*
Prediction Result:
('Male', 'Doctor')
('Male', 'Engineer')
('Female', 'Artist')
('Female', 'Artist')
*/