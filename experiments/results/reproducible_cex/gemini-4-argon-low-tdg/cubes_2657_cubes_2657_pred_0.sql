-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard anti-join, duplicate club names, ordering, multiple players per club, and wrong-table joins (e.g., club_rank, competition_result).
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (1, 'Zeta FC', 'North', '1990');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (2, 'Alpha FC', 'South', '1995');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (3, 'Alpha FC', 'East', '2000');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (4, 'Beta FC', 'West', '2005');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (5, 'Gamma FC', 'Central', '2010');
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (10, 4, 'John Doe', 'Forward', 10.0, 2.0, '1', 10.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (11, 5, 'Jane Smith', 'Back', 15.0, 5.0, '2', 24.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (12, 5, 'Bob Brown', 'Center', 20.0, 1.0, '0', 4.0);
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (1.0, 1, 5.0, 3.0, 2.0, 10.0);
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (2.0, 4, 2.0, 1.0, 1.0, 4.0);
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (100, 2020.0, 'League', 'UK');
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (100, 1, 2, '2-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM club AS LHS WHERE NOT EXISTS(SELECT 1 FROM player AS RHS WHERE (LHS.club_id = RHS.club_id))) ORDER BY name;

/*
Gold Result:
('Alpha FC',)
('Alpha FC',)
('Zeta FC',)
*/

-- Prediction Query
SELECT name FROM CLub WHERE NOT Club_ID IN (SELECT Club_ID FROM player);

/*
Prediction Result:
('Zeta FC',)
('Alpha FC',)
('Alpha FC',)
*/