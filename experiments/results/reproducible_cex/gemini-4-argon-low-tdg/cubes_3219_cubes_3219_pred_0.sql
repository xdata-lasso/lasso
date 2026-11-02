-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT on Residence (Boston has two occupations with count = 2: Doc and Eng).
-- 2. ORDER BY Residence ASC vs insertion order vs DESC (inserting Boston first, then Austin).
-- 3. GROUP BY both (Occupation, Residence) vs GROUP BY Residence only:
--    - Chicago has 1 Doc and 1 Eng (Total for Chicago = 2, but each occupation = 1).
--    - Austin has 2 Docs and 1 Eng (Total for Austin = 3, but Doc = 2).
-- 4. Count boundary conditions: n = 1 (Denver), n = 2 (Boston, Austin), n = 3 (Miami).
-- 5. Unnecessary INNER JOINs with other tables (player_coach is left empty, so INNER JOIN would return empty).
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (1, 'SpA', 'P1', 'M', 'Boston', 'Doc', 10, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (2, 'SpB', 'P2', 'F', 'Boston', 'Doc', 20, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (3, 'SpC', 'P3', 'M', 'Boston', 'Eng', 15, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (4, 'SpD', 'P4', 'F', 'Boston', 'Eng', 25, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (5, 'SpE', 'P5', 'M', 'Austin', 'Doc', 30, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (6, 'SpF', 'P6', 'F', 'Austin', 'Doc', 40, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (7, 'SpG', 'P7', 'M', 'Austin', 'Eng', 50, '4');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (8, 'SpH', 'P8', 'F', 'Chicago', 'Doc', 10, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (9, 'SpI', 'P9', 'M', 'Chicago', 'Eng', 10, '3');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (10, 'SpJ', 'P10', 'F', 'Denver', 'Doc', 100, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (11, 'SpK', 'P11', 'M', 'Miami', 'Doc', 5, '5');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (12, 'SpL', 'P12', 'F', 'Miami', 'Doc', 5, '5');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (13, 'SpM', 'P13', 'M', 'Miami', 'Doc', 5, '5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT residence FROM (SELECT occupation, residence, COUNT(*) AS n FROM player GROUP BY occupation, residence) WHERE (n = 2) ORDER BY residence;

/*
Gold Result:
('Austin',)
('Boston',)
*/

-- Prediction Query
SELECT Residence FROM player GROUP BY Residence HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Austin',)
('Boston',)
('Chicago',)
('Miami',)
*/