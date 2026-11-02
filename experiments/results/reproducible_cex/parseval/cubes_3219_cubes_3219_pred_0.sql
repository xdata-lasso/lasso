-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: player --
INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'pla_103852', 'pla_6f3b4e', -734455130, '4h');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483647, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'pla_103852', 'pla_6f3b4e', 2087640001, 'dposiie5unw');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483646, 'klfa9000t', 'c4ecigce', '76nium52', 'pla_103852', 'pla_6f3b4e', -443340271, 'uo4nrqrofqy');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483645, '5s5b', 'p', '02eutliqa11r', 'pla_103852', 'pla_6f3b4e', 2137741668, 'ytoo3o9hl7');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483644, 'klex14ji', '7zwau2dwyr', '13pyu', 'pla_103852', 'pla_6f3b4e', 176380444, '9rljsl0b4');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483643, 'p5qi2rk', '9v', 'x58pz', 'pla_103852', 'pla_6f3b4e', -1529584866, 'd2');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483642, 'vy9uxj4', 'wb', 'v', 'pla_103852', NULL, 1581736075, 'gndqwnqc');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483641, 'x5hncprjtu0', 'z', '9fjgq8n2f', 'pla_103852', NULL, -1056308489, 'gcb98oz');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483640, '3zb', 'lyr', 'kn6vck6ah0f8', 'pla_103852', NULL, -1520489792, 'wlq7xb');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483639, '72fxa7ryfd', 'z16ni', 'jai', NULL, 'pla_6f3b4e', 1746373317, 'h');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483638, 'ogrgjd8y', 't1afgog', 'itsj3', NULL, 'pla_6f3b4e', -491938169, '1q43');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483637, '1jh3den', 'c68x8vacx', 'afu5w1of7', NULL, 'pla_6f3b4e', 76996700, 'o72ctdc');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483636, 'mfg62', '0v', 'q8qdjpe1', 'pla_103852', 'pla_6f3b4e', -1180042408, '78507cvt');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483635, 'ptt', '6b', 'ou5z', 'pla_103852', 'pla_6f3b4e', 1691780814, '6c4bfkfo');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483634, 'c', '0', '7z2zezjo7wg', 'pla_103852', 'pla_6f3b4e', 1248858185, '5');
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
(None,)
('pla_103852',)
*/