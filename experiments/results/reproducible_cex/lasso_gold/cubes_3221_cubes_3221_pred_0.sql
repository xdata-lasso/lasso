-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (1032, 'Katie Rodriguez', 'Sarah Romero', 'brother', 'claim', 'Midwife', 1033, 'sound');
INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (1034, 'Troy Nielsen', 'Dr. Cynthia Allen', 'decide', 'woman', 'Medical laboratory scientific officer', 1034, 'unit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "player_name", "residence" FROM "player" WHERE ("occupation" <> 'Researcher') ORDER BY player_name, player.player_id NULLS LAST;

/*
Gold Result:
('Dr. Cynthia Allen', 'woman')
('Sarah Romero', 'claim')
*/

-- Prediction Query
SELECT Player_name, residence FROM player WHERE Occupation <> 'Researcher';

/*
Prediction Result:
('Sarah Romero', 'claim')
('Dr. Cynthia Allen', 'woman')
*/