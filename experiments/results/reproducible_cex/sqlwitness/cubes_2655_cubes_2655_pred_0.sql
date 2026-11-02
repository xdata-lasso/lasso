-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO club (club_id, name, region, start_year) VALUES (19, 'default1', 'default2', 'default2'), (21, 'default2', 'default2', NULL), (20, NULL, 'default1', NULL), (1, NULL, 'default2', 'default1'), (10, 'default1', 'default1', NULL);
INSERT INTO player (player_id, club_id, name, position, apps, tries, goals, points) VALUES (21, 20, 'default1', 'default1', 19.0, 1.0, NULL, 11.0), (11, 21, NULL, NULL, 19.0, 19.0, 'default2', 10.0), (19, 21, 'default1', 'default2', 10.0, 11.0, 'default1', 19.0), (20, 21, 'default1', 'default1', 19.0, 20.0, 'default1', 10.0), (1, 10, NULL, 'default1', 20.0, NULL, 'default2', 9.0), (9, 20, 'default2', 'default1', 0.0, 19.0, 'default1', 10.0), (0, 1, 'default1', NULL, 21.0, 9.0, 'default1', 11.0), (10, 10, NULL, 'default2', 20.0, 1.0, NULL, 11.0), (2, 20, 'default1', 'default2', 0.0, 11.0, 'default2', NULL), (3, 10, 'default2', 'default1', 0.0, 20.0, 'default2', 9.0), (4, NULL, 'default1', 'default1', 21.0, 0.0, NULL, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT LHS.player_id AS player_id, LHS.name AS name, LHS.position AS POSITION, LHS.club_id AS club_id, LHS.apps AS apps, LHS.tries AS tries, LHS.goals AS goals, LHS.points AS points, RHS.player_id AS player_id_other, RHS.name AS name_other, RHS.club_id AS club_id_other, RHS.apps AS apps_other, RHS.goals AS goals_other, RHS.points AS points_other FROM (SELECT * FROM player WHERE (points < 20.0 OR points >= 10.0)) AS LHS INNER JOIN (SELECT * FROM player WHERE (points < 20.0 OR points >= 10.0)) AS RHS ON (LHS.position = RHS.position AND LHS.points = RHS.tries)) ORDER BY POSITION;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT POSITION FROM player WHERE Points > 20 INTERSECT SELECT POSITION FROM player WHERE Points < 10;

/*
Prediction Result:
*/