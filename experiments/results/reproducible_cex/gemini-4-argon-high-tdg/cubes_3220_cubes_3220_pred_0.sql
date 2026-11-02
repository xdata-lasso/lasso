-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "club" ("Club_ID", "Club_name", "Region", "Start_year") VALUES (1, 'Alpha Club', 'Brandon', 2000);
INSERT INTO "club" ("Club_ID", "Club_name", "Region", "Start_year") VALUES (2, 'Beta Club', 'Birtle', 2005);
INSERT INTO "coach" ("Coach_ID", "Club_ID", "Coach_name", "Gender", "Rank") VALUES (10, 1, 'Coach One', 'M', 1);
INSERT INTO "coach" ("Coach_ID", "Club_ID", "Coach_name", "Gender", "Rank") VALUES (20, 2, 'Coach Two', 'F', 2);
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (1, 'Zeta Corp', 'Alice', 'F', 'Birtle', 'Doctor', 10, '1');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (2, 'Alpha Inc', 'Bob', 'M', 'Brandon', 'Engineer', 50, '4');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (3, 'Alpha Inc', 'Charlie', 'M', 'Birtle', 'Teacher', 30, '2');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (4, 'Beta LLC', 'Diana', 'F', 'Brandon', 'Artist', 20, '3');
INSERT INTO "player" ("Player_ID", "Sponsor_name", "Player_name", "Gender", "Residence", "Occupation", "Votes", "Rank") VALUES (5, 'Gamma Co', 'Eve', 'F', 'Winnipeg', 'Lawyer', 40, '5');
INSERT INTO "player_coach" ("Player_ID", "Coach_ID", "Starting_year") VALUES (1, 10, 2018);
INSERT INTO "player_coach" ("Player_ID", "Coach_ID", "Starting_year") VALUES (1, 20, 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sponsor_name" FROM "player" WHERE ("residence" = 'Brandon' OR "residence" = 'Birtle') ORDER BY sponsor_name, player.player_id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Alpha Inc',)
('Beta LLC',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT Sponsor_name FROM player WHERE Residence = 'Brandon' OR Residence = 'Birtle';

/*
Prediction Result:
('Zeta Corp',)
('Alpha Inc',)
('Alpha Inc',)
('Beta LLC',)
*/