-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (gender = 'F' vs 'M', 'X', 'f', NULL), ordering by dorm_name, and duplicate dorm_names (to kill DISTINCT mutants).
-- Also includes a Dorm with no students/amenities to kill INNER JOIN mutants.
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'Beta Hall', 100, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'Alpha Hall', 150, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'Alpha Hall', 120, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (4, 'Gamma Hall', 200, 'M');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (5, 'Delta Hall', 80, 'X');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (6, 'Epsilon Hall', 90, 'f');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (7, 'Zeta Hall', 110, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dorm_name" FROM "dorm" WHERE ("gender" = 'F') ORDER BY dorm_name, dorm.dormid NULLS LAST;

/*
Gold Result:
('Alpha Hall',)
('Alpha Hall',)
('Beta Hall',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm WHERE gender = 'F';

/*
Prediction Result:
('Beta Hall',)
('Alpha Hall',)
('Alpha Hall',)
*/