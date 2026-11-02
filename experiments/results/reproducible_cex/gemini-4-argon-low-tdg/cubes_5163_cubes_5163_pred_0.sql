-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'AIB', 'North', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'AIB', 'South', '1995');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (3, 'BOI', 'East', '2000');
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (101, 1, 'P1', 'Forward', 10.0, 2.0, '1', 30.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (102, 1, 'P2', 'Back', 12.0, 3.0, '2', 40.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (103, 2, 'P3', 'Forward', 8.0, 1.0, '0', 10.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (104, 2, 'P4', 'Back', 15.0, 4.0, '3', 20.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (105, 3, 'P5', 'Forward', 20.0, 5.0, '4', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanpoints" AS "avg_t2_points_" FROM (SELECT "club_id", AVG("points") AS "meanpoints" FROM (SELECT * FROM "player" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "club" WHERE ("name" <> 'AIB')) AS RHS WHERE (LHS.club_id = RHS.club_id))) GROUP BY club_id) ORDER BY avg_t2_points_;

/*
Gold Result:
(15.0,)
(35.0,)
*/

-- Prediction Query
SELECT AVG(T2.Points) FROM club AS T1 JOIN player AS T2 ON T1.Club_ID = T2.Club_ID WHERE T1.name = 'AIB';

/*
Prediction Result:
(25.0,)
*/