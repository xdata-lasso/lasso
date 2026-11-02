-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions on Year (<= 2002) and Faculty (< 2002.0),
-- logical operator mutations (AND vs OR), and aggregate function mutations (SUM vs AVG, COUNT, MIN, MAX).
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (1, 'Chico', 'Chico', 'Butte', 1887);
INSERT INTO "Campuses" ("Id", "Campus", "Location", "County", "Year") VALUES (2, 'Fresno', 'Fresno', 'Fresno', 1911);
INSERT INTO "faculty" ("Campus", "Year", "Faculty") VALUES (1, 2002, 100.5);
INSERT INTO "faculty" ("Campus", "Year", "Faculty") VALUES (2, 2001, 200.25);
INSERT INTO "faculty" ("Campus", "Year", "Faculty") VALUES (1, 2002, 2002.0);
INSERT INTO "faculty" ("Campus", "Year", "Faculty") VALUES (2, 2003, 50.0);
INSERT INTO "faculty" ("Campus", "Year", "Faculty") VALUES (1, 2001, 2500.0);
INSERT INTO "faculty" ("Campus", "Year", "Faculty") VALUES (2, 2003, 3000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumfaculty AS sum_faculty_ FROM (SELECT SUM(faculty) AS sumfaculty FROM (SELECT * FROM faculty WHERE (YEAR <= 2002 AND faculty < 2002.0))) ORDER BY sum_faculty_;

/*
Gold Result:
(300.75,)
*/

-- Prediction Query
SELECT SUM(faculty) FROM faculty WHERE YEAR = 2002;

/*
Prediction Result:
(2102.5,)
*/