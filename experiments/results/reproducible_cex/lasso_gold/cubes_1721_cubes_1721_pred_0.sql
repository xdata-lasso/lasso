-- Schema DDL
CREATE TABLE "Campuses" ("Id" INTEGER PRIMARY KEY, "Campus" TEXT, "Location" TEXT, "County" TEXT, "Year" INTEGER);

CREATE TABLE "csu_fees" ("Campus" INTEGER PRIMARY KEY, "Year" INTEGER, "CampusFee" INTEGER, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "degrees" ("Year" INTEGER, "Campus" INTEGER, "Degrees" INTEGER, PRIMARY KEY ("Year", "Campus"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "discipline_enrollments" ("Campus" INTEGER, "Discipline" INTEGER, "Year" INTEGER, "Undergraduate" INTEGER, "Graduate" INTEGER, PRIMARY KEY ("Campus", "Discipline"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "enrollments" ("Campus" INTEGER, "Year" INTEGER, "TotalEnrollment_AY" INTEGER, "FTE_AY" INTEGER, PRIMARY KEY ("Campus", "Year"), FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

CREATE TABLE "faculty" ("Campus" INTEGER, "Year" INTEGER, "Faculty" REAL, FOREIGN KEY ("Campus") REFERENCES "Campuses" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "campuses" ("id", "campus", "location", "county", "year") VALUES (1001, 'purpose', '32181 Johnson Course Apt. 389
New Jamesside, MT 29394', 'list', 1002);
INSERT INTO "faculty" ("campus", "year", "faculty") VALUES (1001, 2001, 2001.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumfaculty AS sum_faculty_ FROM (SELECT SUM(faculty) AS sumfaculty FROM (SELECT * FROM faculty WHERE (YEAR <= 2002 AND faculty < 2002.0))) ORDER BY sum_faculty_;

/*
Gold Result:
(2001.0,)
*/

-- Prediction Query
SELECT SUM(faculty) FROM faculty WHERE YEAR = 2002;

/*
Prediction Result:
(None,)
*/