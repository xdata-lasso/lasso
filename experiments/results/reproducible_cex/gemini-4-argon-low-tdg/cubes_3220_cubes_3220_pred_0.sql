-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('Brandon', 'Birtle', other, NULL), duplicates (SELECT vs SELECT DISTINCT), and ORDER BY sponsor_name (ASC vs DESC, NULL handling)
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (1, 'Zeta Corp', 'Alice', 'F', 'Brandon', 'Doctor', 100, '1');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (2, 'Alpha Inc', 'Bob', 'M', 'Birtle', 'Engineer', 150, '2');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (3, 'Alpha Inc', 'Charlie', 'M', 'Brandon', 'Teacher', 120, '3');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (4, 'Beta LLC', 'David', 'M', 'Winnipeg', 'Lawyer', 200, '4');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (5, 'Gamma Ltd', 'Eve', 'F', NULL, 'Artist', 80, '5');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (6, NULL, 'Frank', 'M', 'Birtle', 'Nurse', 90, '6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sponsor_name" FROM "player" WHERE ("residence" = 'Brandon' OR "residence" = 'Birtle') ORDER BY sponsor_name, player.player_id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Inc',)
('Alpha Inc',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT Sponsor_name FROM player WHERE Residence = 'Brandon' OR Residence = 'Birtle';

/*
Prediction Result:
('Zeta Corp',)
('Alpha Inc',)
('Alpha Inc',)
(None,)
*/