-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'SharedName', 'West', '1970');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'ClubTwo', 'East', '1980');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (3, 'ClubThree', 'North', '1990');
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (1, 2, 'PlayerOne', 'Hooker', 12.0, 2.0, '1', 10.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (2, 1, 'SharedName', 'Prop', 8.0, 0.0, '0', 0.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (3, 3, 'ClubTwo', 'Lock', 14.0, 4.0, '2', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name, player_id FROM (SELECT LHS.player_id AS player_id, LHS.name AS name, LHS.position AS POSITION, LHS.club_id AS club_id, LHS.apps AS apps, LHS.tries AS tries, LHS.goals AS goals, LHS.points AS points, RHS.name AS name_other, RHS.region AS region, RHS.start_year AS start_year FROM player AS LHS INNER JOIN club AS RHS ON (LHS.club_id = RHS.club_id)) ORDER BY name, player_id NULLS LAST;

/*
Gold Result:
('ClubThree', 3)
('ClubTwo', 1)
('SharedName', 2)
*/

-- Prediction Query
SELECT T1.name, T2.Player_id FROM club AS T1 JOIN player AS T2 ON T1.Club_ID = T2.Club_ID;

/*
Prediction Result:
('ClubTwo', 1)
('SharedName', 2)
('ClubThree', 3)
*/