-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Warriors', 'North', '1995');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Titans', 'South', '2001');
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (1, 1, 'Aaron', 'Wing', 10.0, 2.0, '0', 5.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (2, 2, 'Brian', 'Wing', 12.0, 5.0, '10', 25.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (3, 1, 'Charles', 'Center', 15.0, 1.0, '5', 20.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (4, 2, 'David', 'Center', 8.0, 20.0, '0', 4.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (5, 1, 'Edward', 'Fullback', 20.0, 3.0, '2', 10.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (6, 2, 'Frank', 'Fullback', 18.0, 10.0, '1', 15.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (7, 1, 'George', 'Prop', 14.0, 6.0, '0', 12.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (8, 2, 'Henry', 'Prop', 16.0, 9.0, '0', 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT LHS.player_id AS player_id, LHS.name AS name, LHS.position AS POSITION, LHS.club_id AS club_id, LHS.apps AS apps, LHS.tries AS tries, LHS.goals AS goals, LHS.points AS points, RHS.player_id AS player_id_other, RHS.name AS name_other, RHS.club_id AS club_id_other, RHS.apps AS apps_other, RHS.goals AS goals_other, RHS.points AS points_other FROM (SELECT * FROM player WHERE (points < 20.0 OR points >= 10.0)) AS LHS INNER JOIN (SELECT * FROM player WHERE (points < 20.0 OR points >= 10.0)) AS RHS ON (LHS.position = RHS.position AND LHS.points = RHS.tries)) ORDER BY POSITION;

/*
Gold Result:
('Center',)
('Fullback',)
('Wing',)
*/

-- Prediction Query
SELECT POSITION FROM player WHERE Points > 20 INTERSECT SELECT POSITION FROM player WHERE Points < 10;

/*
Prediction Result:
('Wing',)
*/