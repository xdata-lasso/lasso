-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT), NULL handling in Region, and spurious INNER JOINs with empty child tables.
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (3, 'Alpha FC', 'North', '1995');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (1, 'Beta FC', 'South', '1980');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (2, 'Gamma FC', 'North', '2005');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (4, 'Delta FC', NULL, '2010');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (5, 'Epsilon FC', 'East', '1990');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region FROM club ORDER BY region, club.club_id NULLS LAST;

/*
Gold Result:
(None,)
('East',)
('North',)
('North',)
('South',)
*/

-- Prediction Query
SELECT DISTINCT Region FROM club ORDER BY Region ASC;

/*
Prediction Result:
(None,)
('East',)
('North',)
('South',)
*/