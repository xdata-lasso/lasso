-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483648, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', -55602865, -59984348, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', -664303813, -1022641847, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483646, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', -1726781632, 247012447, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483645, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', -1980249628, -734455130, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483644, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1744686505, -1633151678, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483643, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', -252690330, 1115440883, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483642, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1644814318, 1465859724, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483641, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', -1349201381, 1019800248, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483640, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', -1910425938, -845863578, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483639, 'stu_5554fd', 'stu_ebb0d7', NULL, 'f', -1610064545, 429706943, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483638, 'stu_5554fd', 'stu_ebb0d7', NULL, 'f', 462974032, -1137908826, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483637, 'stu_5554fd', 'stu_ebb0d7', NULL, 'f', -918961358, -1602639011, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483636, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', -45536098, 1861536320, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483635, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 44952191, 1151980946, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483634, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1620389964, 546571701, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483633, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 947159877, 1990080517, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483632, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1408123494, -1964997180, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483631, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1149850321, -1833165707, 'db6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT age, COUNT(*) AS n FROM student GROUP BY age) WHERE (age = 18 OR n > age) ORDER BY count___;

/*
Gold Result:
(15,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Student WHERE age = 18;

/*
Prediction Result:
(0,)
*/