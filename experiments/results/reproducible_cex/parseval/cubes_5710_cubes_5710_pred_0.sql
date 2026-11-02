-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: player --
INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'pla_6f821a', -1865039888, 'hria2ypuzhs');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483647, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'pla_6f821a', -1576219117, '5u');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483646, 'w6kl', 'a9', '00t5c4e', 'cigce376nium', 'pla_6f821a', 283598170, 'zbuo4nrq');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (2, 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'pla_6f821a', -1666765085, '72klex14ji7z');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (3, 'au2dwy', 'q13py', '78d99r', 'jsl', 'pla_6f821a', -346339240, 'yp5qi2rk');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483645, '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'pla_6f821a', -1612443122, 'd');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483642, 'lph2gn', 'q', 'nqcx5h', 'cprj', 'G', -841004020, 'dz79fjg');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483641, '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'G', -658391922, 'q7x');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483640, '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 'A', 1129658414, '1afgo');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483639, 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx', 'G', -1762140823, 'w1of77pz');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483638, '72ct', 'c', 'mfg62', '0v', 'G', 820970595, 'qdjpe1io2');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483637, '78507cvt', 'ptt', '6b', 'ou5z', '!', 1691780814, '6c4bfkfo');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483636, 'c', '0', '7z2zezjo7wg', 'd5ysxc', 'I', -405743609, 'g');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483635, '5i3', 'q5l', 'pim5', '58q', 'I', 1817366143, '7p2r94gt');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483634, '2m', 'ajjl', '3', 'okv8uttmu2', 'A', -1252009958, '78lfvyz7');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483633, 'zzbe8yvkv4', 'q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'G', 101754718, 'a9n0jxfo');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483632, 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'G', 709097796, 'lwyng');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483631, '1', 'j', '9erhizgk1yoe', 'o6l0hdt', 'A', -795975227, 'xuzkb52');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483630, 'gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', 'pla_6f821a', 1774679448, 'oaawg96aq');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483629, '0', 'bindz', '9tajz9td', 'n5wcgumbc', 'pla_6f821a', 1295379066, 'd0w9603vzxw1');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483628, 'xe9yf', '7qk', '162nh55y3d', 'ohvu06dza3', 'pla_6f821a', 1595632888, 'mkio18ri2hy');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483627, '08ftp6ewtqxx', 'jaby', 'mzn2mfx7h3', 'p6sto1cj', NULL, 1728926031, 'knzys7dy');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483626, 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', NULL, 1291298007, 'tdqr');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (-2147483625, 'm5', 'wlic7dn2np', '90xdmsqt', 'el', NULL, -1974774786, 'qb9i9f2ccu');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (5, '5k5swwqcgs', '9n8', '4', 'gu7v', 'pla_623e5b', -1865039888, 'hria2ypuzhs');

INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (4, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 'pla_623e5b', -1576219117, '5u');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT occupation FROM (SELECT LHS.player_id AS player_id, LHS.sponsor_name AS sponsor_name, LHS.player_name AS player_name, LHS.gender AS gender, LHS.residence AS residence, LHS.occupation AS occupation, LHS.votes AS votes, LHS.rank AS rank, RHS.player_id AS player_id_other, RHS.sponsor_name AS sponsor_name_other, RHS.player_name AS player_name_other, RHS.gender AS gender_other, RHS.residence AS residence_other, RHS.occupation AS occupation_other, RHS.votes AS votes_other, RHS.rank AS rank_other, RHS.n AS n FROM player AS LHS INNER JOIN (SELECT player_id, sponsor_name, player_name, gender, residence, occupation, votes, rank, n, MAX(n) OVER () AS maxn FROM (SELECT player_id, sponsor_name, player_name, gender, residence, occupation, votes, rank, COUNT(*) OVER () AS n FROM player)) AS RHS ON (LHS.player_id = RHS.maxn)) ORDER BY occupation;

/*
Gold Result:
*/

-- Prediction Query
SELECT Occupation FROM player GROUP BY Occupation ORDER BY COUNT(*) DESC, Occupation NULLS LAST LIMIT 1;

/*
Prediction Result:
('pla_6f821a',)
*/