-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out of order relative to PK), duplicate names (testing DISTINCT/GROUP BY mutants), and unreferenced vs referenced clubs (testing spurious JOIN mutants).
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (1, 'Zeta Club', 'North', '1990');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (2, 'Alpha Club', 'South', '1985');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (3, 'Alpha Club', 'East', '2000');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (4, 'Beta Club', 'West', '2010');
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (1.0, 1, 5.0, 2.0, 1.0, 8.0);
INSERT INTO "club_rank" ("Rank", "Club_ID", "Gold", "Silver", "Bronze", "Total") VALUES (2.0, 1, 3.0, 1.0, 0.0, 4.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (101, 2, 'John Doe', 'Forward', 10.0, 2.0, '1', 10.0);
INSERT INTO "player" ("Player_ID", "Club_ID", "name", "Position", "Apps", "Tries", "Goals", "Points") VALUES (102, 2, 'Jane Smith', 'Back', 15.0, 5.0, '3', 26.0);
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (10, 2022.0, 'League', 'UK');
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (10, 1, 2, '20-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM club ORDER BY name, club.club_id NULLS LAST;

/*
Gold Result:
('Alpha Club',)
('Alpha Club',)
('Beta Club',)
('Zeta Club',)
*/

-- Prediction Query
SELECT name FROM club ORDER BY Start_year ASC, club.club_id NULLS LAST;

/*
Prediction Result:
('Alpha Club',)
('Zeta Club',)
('Alpha Club',)
('Beta Club',)
*/