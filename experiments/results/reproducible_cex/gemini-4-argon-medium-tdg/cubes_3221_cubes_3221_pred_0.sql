-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT vs ALL projections, tie-breaking in ORDER BY (player_name, player_id), and NULL handling in projected/ordered columns.
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (10, 'SponsorA', 'Alex', 'M', 'Boston', 'Doctor', 10, '1');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (5, 'SponsorB', 'Alex', 'M', 'Boston', 'Teacher', 20, '2');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (20, 'SponsorC', 'Alex', 'F', 'Chicago', 'Artist', 30, '3');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (15, 'SponsorD', NULL, 'F', 'Seattle', 'Lawyer', 40, '4');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (2, 'SponsorE', NULL, 'M', NULL, 'Lawyer', 50, '5');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (null, 'SponsorF', 'Alex', 'M', 'Austin', 'Pilot', 60, '6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player_name", "residence" FROM "player" WHERE ("occupation" <> 'Researcher') ORDER BY player_name, player.player_id NULLS LAST;

/*
Gold Result:
(None, None)
(None, 'Seattle')
('Alex', 'Boston')
('Alex', 'Boston')
('Alex', 'Chicago')
('Alex', 'Austin')
*/

-- Prediction Query
SELECT Player_name, residence FROM player WHERE Occupation <> 'Researcher';

/*
Prediction Result:
(None, None)
('Alex', 'Boston')
('Alex', 'Boston')
(None, 'Seattle')
('Alex', 'Chicago')
('Alex', 'Austin')
*/