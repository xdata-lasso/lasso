-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic threshold boundary (points < 20.0, points = 20.0, points > 20.0),
-- NULL handling in Points and Position, and ORDER BY Position.
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (1, 'Alpha FC', 'North', '1990');
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (1, 1, 'P1', 'Forward', 10.0, 2.0, '1', 19.9);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (2, 1, 'P2', 'Wing', 10.0, 4.0, '0', 20.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (3, 1, 'P3', 'Back', 10.0, 5.0, '0', 25.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (4, 1, 'P4', 'Center', 10.0, 0.0, '0', NULL);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (5, 1, 'P5', NULL, 10.0, 6.0, '0', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT points, POSITION, AVG(points) AS meanpoints FROM player GROUP BY points, POSITION) WHERE (points >= 20.0 OR meanpoints < points) ORDER BY POSITION;

/*
Gold Result:
(None,)
('Back',)
('Wing',)
*/

-- Prediction Query
SELECT POSITION FROM player GROUP BY name HAVING AVG(Points) >= 20;

/*
Prediction Result:
('Wing',)
('Back',)
(None,)
*/