-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: club --
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (-2147483648, '9n8', '4', 'gu7v');

-- Inserting into table: player --
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483648, -2147483648, '5k5swwqcgs', 'pla_28c3df', 86.520366, 65.761562, 'hria2ypuzhs', 49161.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483647, -2147483648, '5k5swwqcgs', 'pla_81a805', 711.020062, 944.247544, 'p', 0.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483646, -2147483648, '5k5swwqcgs', 'pla_343d0a', 320.851235, 113.643485, 'l', 42735.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (2, -2147483648, 'tilbn', 'pla_28c3df', 787.938887, 986.066566, 'dposiie5unw', 49161.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (3, -2147483648, 'tilbn', 'pla_28c3df', 768.216462, 83.204633, '9', 0.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483645, -2147483648, 'tilbn', 'pla_343d0a', 627.258639, 801.414196, '0t5c4ecigce', 42735.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483642, -2147483648, '76nium52', 'pla_28c3df', 21.917736, 325.900094, 'nrqrofqy', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483641, -2147483648, '76nium52', 'pla_81a805', 488.977171, 285.519313, 'bbp02eutliqa', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483640, -2147483648, '76nium52', 'pla_343d0a', 982.938576, 274.580687, 'ytoo3o9', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483639, -2147483648, 'l7', 'pla_28c3df', 958.92567, 164.991544, 'x1', 49161.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483638, -2147483648, 'l7', 'pla_81a805', 144.777217, 598.409165, 'wau2dwy', 0.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483637, -2147483648, 'l7', 'pla_343d0a', 262.105498, 591.461096, 'yu78', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483636, -2147483648, '9', NULL, 182.777264, 943.791649, 'l0b4y', 0.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483635, -2147483648, '9', NULL, 495.297639, 261.217059, 'rkf9vqx5', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483634, -2147483648, '9', NULL, 698.16972, 690.435103, '0f8jegd', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483633, -2147483648, 'vy9uxj4', 'wb', 50.647649, 185.427628, 'h2gn', 20.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (4, -2147483648, 'wnqcx', '5hncprjtu0d', 395.809081, 552.472052, 'fjgq8n2f3d', 656.638403);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (5, -2147483648, 'pla_f5cc74', '0gcb98', 221.227801, 401.142827, '3zb', 2.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (6, -2147483648, 'pla_f5cc74', 'yrk', 615.222139, 203.331848, 'vck6ah0f8', 3.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (7, -2147483648, 'wwlq7', 'xb72fxa7ryfd', 276.61064, 399.319982, '16nijjai5dh', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (8, -2147483648, 'grgj', '8', 740.059813, 388.212083, 't1afgog', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (9, -2147483648, 'tsj', 'ayxp1q43', 787.642728, 947.945777, 'jh3den8c68', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (10, -2147483648, 'vacx7afu5', '1of77p', 398.637058, 689.065203, '72ctdctmfg62', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (11, -2147483648, 'v5q8qdj', 'e1io', 443.690199, 518.274259, '07cvtjpt', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (12, -2147483648, '6b', 'ou5z', 988.279797, 893.898414, '6c4bfkfo', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (13, -2147483648, 'cd07z2zezjo7', 'wgxd5ysxcm', 914.215057, 900.850089, '0oztdgj5i3lq', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (14, -2147483648, 'npi', '5k58', 251.966916, 723.188966, '27p2r', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (15, -2147483648, 'th', '2mnajjla3o', 904.028668, 167.474325, 'uttmu2ne5', 1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (16, -2147483648, 'vy', '7zzbe8y', 335.639672, 743.007715, '42q7sx58b4', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT points, POSITION, AVG(points) AS meanpoints FROM player GROUP BY points, POSITION) WHERE (points >= 20.0 OR meanpoints < points) ORDER BY POSITION;

/*
Gold Result:
('5hncprjtu0d',)
('pla_28c3df',)
('pla_343d0a',)
('wb',)
*/

-- Prediction Query
SELECT POSITION FROM player GROUP BY name HAVING AVG(Points) >= 20;

/*
Prediction Result:
('pla_28c3df',)
('pla_28c3df',)
('pla_343d0a',)
('wb',)
('5hncprjtu0d',)
*/