-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Universal quantification vs Existential quantification (Location 'Loc_Mixed' has both <800 and >=800).
-- 2. Boundary values around 800 (799, 800, 801).
-- 3. Duplicate locations (<800) to test DISTINCT.
-- 4. Unscheduled cinemas (since schedule table is empty) to kill mutants that inner-join with schedule.
-- 5. Ordering of results (Loc_A_799, Loc_B_Dup, Loc_Z_Low).
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Cin_799', 2000, 799, 'Loc_A_799');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'Cin_800', 2001, 800, 'Loc_Boundary_800');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (3, 'Cin_801', 2002, 801, 'Loc_Boundary_801');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (4, 'Cin_Mixed_Low', 2003, 500, 'Loc_Mixed');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (5, 'Cin_Mixed_High', 2004, 800, 'Loc_Mixed');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (6, 'Cin_Dup_1', 2005, 300, 'Loc_B_Dup');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (7, 'Cin_Dup_2', 2006, 400, 'Loc_B_Dup');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (8, 'Cin_Z', 2007, 100, 'Loc_Z_Low');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT * FROM cinema AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM cinema WHERE (capacity >= 800)) AS RHS WHERE (LHS.location = RHS.location))) ORDER BY LOCATION;

/*
Gold Result:
('Loc_A_799',)
('Loc_B_Dup',)
('Loc_Z_Low',)
*/

-- Prediction Query
SELECT LOCATION FROM cinema EXCEPT SELECT LOCATION FROM cinema WHERE capacity > 800;

/*
Prediction Result:
('Loc_A_799',)
('Loc_B_Dup',)
('Loc_Boundary_800',)
('Loc_Mixed',)
('Loc_Z_Low',)
*/