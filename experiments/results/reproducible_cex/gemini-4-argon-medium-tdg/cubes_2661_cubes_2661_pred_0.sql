-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions (counts of 1, 4, 5, 6), ordering (insert order vs alphabetical vs count order), and inner join mutants with competition_result.
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (1, 'Alpha', 'North', '1990');
INSERT INTO "club" ("Club_ID", "name", "Region", "Start_year") VALUES (2, 'Beta', 'South', '1995');
-- 'Tournament' has count 4 (boundary < 5, should be included)
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (1, 2001, 'Tournament', 'USA');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (2, 2001, 'Tournament', 'USA');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (3, 2002, 'Tournament', 'UK');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (4, 2003, 'Tournament', 'France');
-- 'Cup' has count 1 (should be included, tests ordering: 'Cup' < 'Tournament' alphabetically, but count 1 < 4)
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (5, 2000, 'Cup', 'Spain');
-- 'League' has count 5 (boundary = 5, should be excluded; kills <= 5 mutants)
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (6, 2001, 'League', 'Germany');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (7, 2002, 'League', 'Germany');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (8, 2003, 'League', 'Italy');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (9, 2004, 'League', 'Italy');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (10, 2005, 'League', 'France');
-- 'Friendly' has count 6 (boundary > 5, should be excluded; kills > 5 or != 5 mutants)
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (11, 2001, 'Friendly', 'Brazil');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (12, 2002, 'Friendly', 'Brazil');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (13, 2003, 'Friendly', 'Argentina');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (14, 2004, 'Friendly', 'Argentina');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (15, 2005, 'Friendly', 'Chile');
INSERT INTO "competition" ("Competition_ID", "Year", "Competition_type", "Country") VALUES (16, 2006, 'Friendly', 'Chile');
-- Only some competitions have results (kills mutants that unnecessarily join competition_result)
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (1, 1, 2, '2-1');
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (6, 1, 2, '0-0');
INSERT INTO "competition_result" ("Competition_ID", "Club_ID_1", "Club_ID_2", "Score") VALUES (7, 1, 2, '1-3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT competition_type FROM (SELECT competition_type, COUNT(*) AS n FROM competition GROUP BY competition_type) WHERE (n < 5) ORDER BY competition_type;

/*
Gold Result:
('Cup',)
('Tournament',)
*/

-- Prediction Query
SELECT Competition_type FROM competition GROUP BY Competition_type HAVING COUNT(*) <= 5;

/*
Prediction Result:
('Cup',)
('League',)
('Tournament',)
*/