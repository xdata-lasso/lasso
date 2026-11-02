-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483648, 'stu_5554fd', 'stu_ebb0d7', NULL, 'f', -55602865, -59984348, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'stu_5554fd', 'stu_ebb0d7', NULL, 'f', -664303813, -1022641847, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'stu_5554fd', 'stu_ebb0d7', -1726781632, 'f', 247012447, -1980249628, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483645, 'stu_5554fd', 'stu_ebb0d7', NULL, 'f', -734455130, 1744686505, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483644, 'stu_5554fd', 'stu_ebb0d7', NULL, 'f', -1633151678, -252690330, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (2, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1115440883, 1644814318, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (3, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1465859724, -1349201381, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (4, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1019800248, -1910425938, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (5, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', -845863578, -1610064545, 'db6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT stuid FROM (SELECT * FROM (SELECT * FROM (SELECT sex, stuid, MAX(age) AS maxage FROM student GROUP BY sex, stuid) ORDER BY maxage DESC) LIMIT 1);

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT StuID FROM Student WHERE age = (SELECT MAX(age) FROM Student);

/*
Prediction Result:
(2,)
(3,)
(4,)
(5,)
*/