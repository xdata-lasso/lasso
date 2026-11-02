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
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (1, 1, 'John Smith', 'M', 1);
INSERT INTO coach (Coach_ID, Club_ID, Coach_name, Gender, Rank) VALUES (2, 1, 'Jane Doe', 'F', 2);
INSERT INTO match_result (Rank, Club_ID, Gold, Big_Silver, Small_Silver, Bronze, Points) VALUES (1, 1, 5, 3, 2, 1, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM player ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM player;

/*
Prediction Result:
(0,)
*/