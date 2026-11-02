-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (1, 'S1', 'P1', 'M', 'NY', 'Doc', 10, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (2, 'S2', 'P2', 'F', 'NY', 'Eng', 20, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT residence FROM (SELECT occupation, residence, COUNT(*) AS n FROM player GROUP BY occupation, residence) WHERE (n = 2) ORDER BY residence;

/*
Gold Result:
*/

-- Prediction Query
SELECT Residence FROM player GROUP BY Residence HAVING COUNT(*) >= 2;

/*
Prediction Result:
('NY',)
*/