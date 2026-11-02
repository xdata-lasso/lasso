-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (1, 'AIB', 'North', '1990');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (2, 'AIB', 'South', '1995');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (3, 'Ballymena', 'East', '2000');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (4, 'AIB', 'West', '2005');
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (1.0, 1, 5.0, 3.0, 2.0, 10.0);
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (2.0, 3, 2.0, 1.0, 1.0, 4.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (101, 1, 'Alice', 'Forward', 10.0, 2.0, '4', 40.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (102, 1, 'Bob', 'Back', 12.0, 3.0, '5', 40.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (103, 1, 'Charlie', 'Wing', 14.0, 4.0, '6', 100.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (104, 2, 'David', 'Center', 8.0, 1.0, '2', 10.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (105, 2, 'Eve', 'Fullback', 9.0, 2.0, '3', 20.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (106, 3, 'Frank', 'Forward', 20.0, 5.0, '10', 5.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (107, 3, 'Grace', 'Back', 22.0, 6.0, '12', 15.0);
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (1, 2020.0, 'League', 'Ireland');
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (1, 1, 3, '20-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanpoints" AS "avg_t2_points_" FROM (SELECT "club_id", AVG("points") AS "meanpoints" FROM (SELECT * FROM "player" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "club" WHERE ("name" <> 'AIB')) AS RHS WHERE (LHS.club_id = RHS.club_id))) GROUP BY club_id) ORDER BY avg_t2_points_;

/*
Gold Result:
(15.0,)
(60.0,)
*/

-- Prediction Query
SELECT AVG(T2.Points) FROM club AS T1 JOIN player AS T2 ON T1.Club_ID = T2.Club_ID WHERE T1.name = 'AIB';

/*
Prediction Result:
(42.0,)
*/