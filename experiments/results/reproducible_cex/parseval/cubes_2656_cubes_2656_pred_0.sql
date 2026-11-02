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
INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (2, -2147483648, 'pla_d895cb', 'gu7v', 86.520366, 65.761562, 'hria2ypuzhs', 663.049759);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (3, -2147483648, 'pla_d895cb', 'b', 749.826493, 503.083789, 'hvdltt', 125.12763);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483646, -2147483648, 'nprmdposii', '5u', 933.422701, 345.718563, 'klfa9000t', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483645, -2147483648, '4', 'ecigce376n', 805.746877, 322.782838, '52zbuo4nrq', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483644, -2147483648, 'pla_d895cb', 'fqyp', 488.977171, 285.519313, 'bbp02eutliqa', 427.383654);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483643, -2147483648, NULL, 'yytoo', 882.985782, 228.583847, 'l7', 443.457804);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483642, -2147483648, NULL, 'ex1', 482.572691, 133.223471, 'zwau2dwyr', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483641, -2147483648, NULL, '3pyu78d', 550.03107, 272.376524, 'sl0', NULL);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483640, -2147483648, NULL, 'yp5qi2rk', 811.601922, 92.834164, 'qx58pz', 410.133844);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (-2147483639, -2147483648, 'pla_d895cb', '8jegd21vy9ux', 585.18838, 152.494591, 'wb', 50.647649);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (4, -2147483648, 'h2gn', 'q', 345.35543, 250.856497, 'x5hncprjtu0', 0.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (5, -2147483648, '79fjgq8', 'n2f3dqv0gcb9', 540.154414, 874.028321, '3zb', -1.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (6, -2147483648, 'yrk', 'n6vck6ah0f', 532.326819, 282.822068, 'lq7xb7', 0.0);

INSERT INTO "player" ("player_id", "club_id", "name", "position", "apps", "tries", "goals", "points") VALUES (7, -2147483648, 'xa', '7ryfdrz16n', 130.468488, 151.555666, 'i', -1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.player_id AS player_id, LHS.name AS name, LHS.position AS POSITION, LHS.club_id AS club_id, LHS.apps AS apps, LHS.tries AS tries, LHS.goals AS goals, LHS.points AS points, LHS.meanpoints AS meanpoints, RHS.player_id AS player_id_other, RHS.name AS name_other, RHS.position AS position_other, RHS.club_id AS club_id_other, RHS.apps AS apps_other, RHS.tries AS tries_other, RHS.goals AS goals_other, RHS.points AS points_other, RHS.meanpoints AS meanpoints_other FROM (SELECT player_id, name, POSITION, club_id, apps, tries, goals, points, AVG(points) OVER () AS meanpoints FROM player) AS LHS CROSS JOIN (SELECT player_id, name, POSITION, club_id, apps, tries, goals, points, AVG(points) OVER () AS meanpoints FROM player) AS RHS) WHERE (points >= meanpoints_other AND points_other > meanpoints_other) ORDER BY name;

/*
Gold Result:
(None,)
('pla_d895cb',)
*/

-- Prediction Query
SELECT name FROM player WHERE points > (SELECT AVG(points) FROM player);

/*
Prediction Result:
('pla_d895cb',)
(None,)
(None,)
('pla_d895cb',)
*/