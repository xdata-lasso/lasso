-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dorm --
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'dor_2cb45e', 0, 'dor_a240c9');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'dor_2cb45e', 0, 'dor_a240c9');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'dor_2cb45e', 0, 'dor_a240c9');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (4, 'dor_2cb45e', 100, 'dor_a240c9');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (5, NULL, 0, 'dor_a240c9');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483643, 'dor_2cb45e', 0, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (6, 'dor_6d3505', 300, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (7, 'dor_6d3505', NULL, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (8, 'dor_6d3505', NULL, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (9, 'dor_6d3505', NULL, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (10, 'dor_6d3505', NULL, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (11, 'dor_6d3505', NULL, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (12, 'dor_6d3505', NULL, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (13, 'dor_6d3505', NULL, '7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name, gender FROM dorm WHERE (student_capacity >= 300 OR student_capacity < 100) ORDER BY dorm_name, dorm.dormid NULLS LAST;

/*
Gold Result:
(None, 'dor_a240c9')
('dor_2cb45e', None)
('dor_2cb45e', 'dor_a240c9')
('dor_2cb45e', 'dor_a240c9')
('dor_2cb45e', 'dor_a240c9')
('dor_6d3505', '7')
*/

-- Prediction Query
SELECT dorm_name, gender FROM dorm WHERE student_capacity > 300 OR student_capacity < 100;

/*
Prediction Result:
('dor_2cb45e', 'dor_a240c9')
('dor_2cb45e', 'dor_a240c9')
('dor_2cb45e', 'dor_a240c9')
(None, 'dor_a240c9')
('dor_2cb45e', None)
*/