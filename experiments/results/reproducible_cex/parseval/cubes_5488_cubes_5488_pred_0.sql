-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dorm --
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'dor_a1aca4', 1, 'dor_bd8c3a');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483647, NULL, -55602865, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483646, 'dor_6d3505', -59984348, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (NULL, 'dor_6d3505', -664303813, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (NULL, 'dor_a1aca4', NULL, 'dor_bd8c3a');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (NULL, 'dor_4761f9', 1, 'dor_4b1a8a');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'dor_6d3505', -1022641847, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'dor_6d3505', -1726781632, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483643, 'q_2_3a9391', 247012447, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483642, 'q_2_3a9391', -1980249628, '7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM (SELECT * FROM (SELECT * FROM (SELECT dormid, dorm_name, MAX(student_capacity) OVER () AS student_capacity, gender FROM dorm) ORDER BY dormid DESC) LIMIT 1);

/*
Gold Result:
('dor_6d3505',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm ORDER BY student_capacity DESC, dorm.dormid NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_3a9391',)
*/