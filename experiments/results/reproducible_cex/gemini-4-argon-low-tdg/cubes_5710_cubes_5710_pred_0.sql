-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (1, 'SpA', 'Alice', 'F', 'Res1', 'Student', 100, '1');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (2, 'SpB', 'Bob', 'M', 'Res2', 'Doctor', 200, '2');
INSERT INTO player (Player_ID, Sponsor_name, Player_name, Gender, Residence, Occupation, Votes, Rank) VALUES (3, 'SpC', 'Charlie', 'M', 'Res3', 'Engineer', 300, '3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT occupation FROM (SELECT LHS.player_id AS player_id, LHS.sponsor_name AS sponsor_name, LHS.player_name AS player_name, LHS.gender AS gender, LHS.residence AS residence, LHS.occupation AS occupation, LHS.votes AS votes, LHS.rank AS rank, RHS.player_id AS player_id_other, RHS.sponsor_name AS sponsor_name_other, RHS.player_name AS player_name_other, RHS.gender AS gender_other, RHS.residence AS residence_other, RHS.occupation AS occupation_other, RHS.votes AS votes_other, RHS.rank AS rank_other, RHS.n AS n FROM player AS LHS INNER JOIN (SELECT player_id, sponsor_name, player_name, gender, residence, occupation, votes, rank, n, MAX(n) OVER () AS maxn FROM (SELECT player_id, sponsor_name, player_name, gender, residence, occupation, votes, rank, COUNT(*) OVER () AS n FROM player)) AS RHS ON (LHS.player_id = RHS.maxn)) ORDER BY occupation;

/*
Gold Result:
('Engineer',)
*/

-- Prediction Query
SELECT Occupation FROM player GROUP BY Occupation ORDER BY COUNT(*) DESC, Occupation NULLS LAST LIMIT 1;

/*
Prediction Result:
('Doctor',)
*/