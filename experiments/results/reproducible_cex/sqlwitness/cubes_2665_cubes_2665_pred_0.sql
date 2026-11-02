-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO club (club_id, name, region, start_year) VALUES (1, NULL, 'default2', 'default2'), (0, 'default1', NULL, NULL), (2, 'default1', 'default2', 'default1'), (3, NULL, NULL, NULL), (4, NULL, 'default1', NULL), (5, 'default2', 'default2', 'default1');
INSERT INTO player (player_id, club_id, name, position, apps, tries, goals, points) VALUES (0, 4, 'default1', NULL, NULL, NULL, NULL, 1.0), (1, 5, NULL, 'default2', NULL, NULL, NULL, 1.0), (2, 4, NULL, NULL, 1.0, 1.0, NULL, NULL), (3, 1, NULL, 'default1', NULL, 1.0, NULL, NULL), (4, 2, NULL, NULL, NULL, 1.0, 'default2', 1.0), (5, 5, NULL, NULL, NULL, 0.0, 'default2', 0.0), (6, 5, NULL, 'default1', 1.0, 1.0, NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name, player_id FROM (SELECT LHS.player_id AS player_id, LHS.name AS name, LHS.position AS POSITION, LHS.club_id AS club_id, LHS.apps AS apps, LHS.tries AS tries, LHS.goals AS goals, LHS.points AS points, RHS.name AS name_other, RHS.region AS region, RHS.start_year AS start_year FROM player AS LHS INNER JOIN club AS RHS ON (LHS.club_id = RHS.club_id)) ORDER BY name, player_id NULLS LAST;

/*
Gold Result:
(None, 0)
(None, 2)
(None, 3)
('default1', 4)
('default2', 1)
('default2', 5)
('default2', 6)
*/

-- Prediction Query
SELECT T1.name, T2.Player_id FROM club AS T1 JOIN player AS T2 ON T1.Club_ID = T2.Club_ID;

/*
Prediction Result:
(None, 0)
('default2', 1)
(None, 2)
(None, 3)
('default1', 4)
('default2', 5)
('default2', 6)
*/