-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering on gender ('F' vs 'M', 'f', 'X', NULL), duplicate dorm_names (to catch SELECT DISTINCT mutants), and alphabetical ordering of dorm_name.
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'Zeta Hall', 100, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'Alpha Hall', 150, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'Alpha Hall', 200, 'F');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (4, 'Beta Hall', 120, 'M');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (5, 'Gamma Hall', 80, 'f');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (6, 'Delta Hall', 90, NULL);
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (7, 'Epsilon Hall', 110, 'X');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dorm_name" FROM "dorm" WHERE ("gender" = 'F') ORDER BY dorm_name, dorm.dormid NULLS LAST;

/*
Gold Result:
('Alpha Hall',)
('Alpha Hall',)
('Zeta Hall',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm WHERE gender = 'F';

/*
Prediction Result:
('Zeta Hall',)
('Alpha Hall',)
('Alpha Hall',)
*/