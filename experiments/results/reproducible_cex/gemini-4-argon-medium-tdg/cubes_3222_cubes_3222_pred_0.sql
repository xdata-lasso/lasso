-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (Gender ASC, Player_ID ASC), inverted relationship between Player_ID and Occupation,
-- SELECT DISTINCT mutations, and spurious JOINs with player_coach, coach, club, and match_result.
INSERT INTO "club" ("Club_ID", "Club_name", "Region", "Start_year") VALUES (1, 'Club Alpha', 'North', 2000);
INSERT INTO "coach" ("Coach_ID", "Club_ID", "Coach_name", "Gender", "Rank") VALUES (1, 1, 'Coach John', 'M', 1);
INSERT INTO "coach" ("Coach_ID", "Club_ID", "Coach_name", "Gender", "Rank") VALUES (2, 1, 'Coach Jane', 'F', 2);
INSERT INTO "match_result" ("Rank", "Club_ID", "Gold", "Big_Silver", "Small_Silver", "Bronze", "Points") VALUES (1, 1, 5, 3, 2, 1, 100);
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (10, 'SponsorX', 'Alice', 'F', 'CityA', 'Zookeeper', 500, '2');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (20, 'SponsorY', 'Betty', 'F', 'CityB', 'Accountant', 100, '1');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (30, 'SponsorZ', 'Clara', 'F', 'CityC', 'Accountant', 300, '3');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (5, 'SponsorW', 'David', 'M', 'CityD', 'Doctor', 800, '4');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (15, 'SponsorV', 'Evan', 'M', 'CityE', 'Baker', 200, '5');
-- Player 10 has 2 coaches (tests if inner join duplicates rows), Player 20 has 1 coach, others have 0 (tests if inner join drops rows).
INSERT INTO "player_coach" ("Player_ID", "Coach_ID", "Starting_year") VALUES (10, 1, 2018);
INSERT INTO "player_coach" ("Player_ID", "Coach_ID", "Starting_year") VALUES (10, 2, 2019);
INSERT INTO "player_coach" ("Player_ID", "Coach_ID", "Starting_year") VALUES (20, 1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gender, occupation FROM player ORDER BY gender, player.player_id NULLS LAST;

/*
Gold Result:
('F', 'Zookeeper')
('F', 'Accountant')
('F', 'Accountant')
('M', 'Doctor')
('M', 'Baker')
*/

-- Prediction Query
SELECT Gender, Occupation FROM player;

/*
Prediction Result:
('M', 'Doctor')
('F', 'Zookeeper')
('M', 'Baker')
('F', 'Accountant')
('F', 'Accountant')
*/