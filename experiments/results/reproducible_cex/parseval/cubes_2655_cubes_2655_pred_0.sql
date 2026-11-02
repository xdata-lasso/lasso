-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: club --
INSERT INTO "club" ("club_id", "name", "region", "start_year") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4');

-- Inserting into table: player --
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483648, -2147483648, 'gu7v', 'pla_13887d', 86.520366, 65.761562, 'hria2ypuzhs', 20.01);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483647, -2147483648, 'wbbp6luhvdlt', 'pla_22121d', 304.02808, 182.319045, 'nprmdposii', 9.99);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (2, -2147483648, 'unw6klfa', 'pla_13887d', 587.783596, 558.971814, '00t5c4e', 20.01);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (3, -2147483648, 'gce', 'pla_13887d', 467.07027, 875.837169, 'nium52zbu', 20.01);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483646, -2147483648, 'nrqrofqy', 'pla_22121d', 242.260296, 938.694822, 'bbp02eut', 9.99);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483643, -2147483648, 'qa1', 'pla_71a663', 982.938576, 274.580687, 'ytoo3o9', 9.99);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483642, -2147483648, '72k', 'pla_13887d', 176.308171, 763.856372, 'x14ji7zwau2d', 20.01);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483641, -2147483648, 'yrq13pyu78d9', 'pla_58cd71', 557.003843, 182.777264, 'l0b4y', 20.01);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483640, -2147483648, '2rk', 'pla_13887d', 811.601922, 92.834164, 'qx58pz', 20.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483639, -2147483648, 'f8jegd21vy9u', 'pla_22121d', 367.405851, 835.894437, 'hwbdvlph', 9.99);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483638, -2147483648, 'nd', 'pla_13887d', 893.16532, 254.83756, 'qcx5', 20.01);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483637, -2147483648, 'cprj', 'pla_22121d', 304.188492, 415.830002, '79fjgq8', 10.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483636, -2147483648, 'f3dqv0gc', NULL, 879.800692, 887.207631, 'ozk3zbily', 20.01);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483635, -2147483648, 'kn6vck6ah0f8', NULL, 145.983385, 346.706184, 'q7x', 9.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT LHS.player_id AS player_id, LHS.name AS name, LHS.position AS POSITION, LHS.club_id AS club_id, LHS.apps AS apps, LHS.tries AS tries, LHS.goals AS goals, LHS.points AS points, RHS.player_id AS player_id_other, RHS.name AS name_other, RHS.club_id AS club_id_other, RHS.apps AS apps_other, RHS.goals AS goals_other, RHS.points AS points_other FROM (SELECT * FROM player WHERE (points < 20.0 OR points >= 10.0)) AS LHS INNER JOIN (SELECT * FROM player WHERE (points < 20.0 OR points >= 10.0)) AS RHS ON (LHS.position = RHS.position AND LHS.points = RHS.tries)) ORDER BY POSITION;

/*
Gold Result:
*/

-- Prediction Query
SELECT POSITION FROM player WHERE Points > 20 INTERSECT SELECT POSITION FROM player WHERE Points < 10;

/*
Prediction Result:
(None,)
*/