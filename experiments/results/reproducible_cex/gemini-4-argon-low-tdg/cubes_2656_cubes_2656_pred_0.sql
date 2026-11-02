-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Club Alpha', 'North', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Club Beta', 'South', '1995');
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (1, 1, 'Charlie', 'Forward', 10.0, 2.0, '1', 10.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (2, 1, 'Alice', 'Back', 15.0, 4.0, '2', 20.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (3, 2, 'Bob', 'Forward', 20.0, 6.0, '3', 30.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (4, 2, 'Bob', 'Wing', 25.0, 8.0, '4', 20.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (5, 1, 'Dave', 'Center', 12.0, 1.0, '0', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.player_id AS player_id, LHS.name AS name, LHS.position AS POSITION, LHS.club_id AS club_id, LHS.apps AS apps, LHS.tries AS tries, LHS.goals AS goals, LHS.points AS points, LHS.meanpoints AS meanpoints, RHS.player_id AS player_id_other, RHS.name AS name_other, RHS.position AS position_other, RHS.club_id AS club_id_other, RHS.apps AS apps_other, RHS.tries AS tries_other, RHS.goals AS goals_other, RHS.points AS points_other, RHS.meanpoints AS meanpoints_other FROM (SELECT player_id, name, POSITION, club_id, apps, tries, goals, points, AVG(points) OVER () AS meanpoints FROM player) AS LHS CROSS JOIN (SELECT player_id, name, POSITION, club_id, apps, tries, goals, points, AVG(points) OVER () AS meanpoints FROM player) AS RHS) WHERE (points >= meanpoints_other AND points_other > meanpoints_other) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT name FROM player WHERE points > (SELECT AVG(points) FROM player);

/*
Prediction Result:
('Bob',)
*/