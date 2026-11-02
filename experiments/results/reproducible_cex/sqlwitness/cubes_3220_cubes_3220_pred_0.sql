-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO player (player_id, sponsor_name, player_name, gender, residence, occupation, votes, rank) VALUES (0, 'Brandon', 'Birtle', 'Birtle', 'Brandon', 'default1', 0, 'default2'), (1, NULL, 'Birtle', NULL, 'default2', NULL, NULL, 'default2'), (2, 'default2', 'Birtle', 'default1', 'Birtle', 'Brandon', NULL, NULL), (3, 'default2', 'Brandon', 'Birtle', NULL, 'default1', 0, 'Birtle'), (4, NULL, 'default2', 'default1', 'Birtle', 'default2', NULL, 'Brandon'), (5, NULL, 'default1', 'Birtle', NULL, 'Brandon', NULL, 'default2'), (6, 'Birtle', NULL, 'default2', NULL, 'default2', 1, 'default1'), (7, 'default1', NULL, NULL, 'default2', 'Brandon', 0, 'default2'), (8, NULL, 'Brandon', 'default2', 'Brandon', 'default1', NULL, 'default2'), (9, 'Brandon', NULL, 'default1', 'default2', 'Birtle', 0, 'Brandon');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sponsor_name" FROM "player" WHERE ("residence" = 'Brandon' OR "residence" = 'Birtle') ORDER BY sponsor_name, player.player_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('Brandon',)
('default2',)
*/

-- Prediction Query
SELECT Sponsor_name FROM player WHERE Residence = 'Brandon' OR Residence = 'Birtle';

/*
Prediction Result:
('Brandon',)
('default2',)
(None,)
(None,)
*/