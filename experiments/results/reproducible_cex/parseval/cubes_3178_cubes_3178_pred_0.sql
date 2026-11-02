-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483648, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'stu_5554fd', 'stu_ebb0d7', -59984348, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483646, 'stu_5554fd', 'stu_ebb0d7', -664303813, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483645, 'stu_5554fd', 'stu_ebb0d7', -1022641847, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483644, 'stu_5554fd', 'stu_ebb0d7', -1726781632, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483643, 'stu_5554fd', 'stu_ebb0d7', 247012447, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483642, 'stu_5554fd', 'stu_ebb0d7', -1980249628, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483641, 'stu_5554fd', 'stu_ebb0d7', -734455130, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483640, 'stu_5554fd', 'stu_ebb0d7', 1744686505, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483639, 'stu_5554fd', 'stu_ebb0d7', -1633151678, 'f', NULL, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483638, 'stu_5554fd', 'stu_ebb0d7', -252690330, 'f', NULL, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483637, 'stu_5554fd', 'stu_ebb0d7', 1115440883, 'f', NULL, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483636, 'stu_5554fd', 'stu_ebb0d7', 1644814318, 'f', 1, NULL, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483635, 'stu_5554fd', 'stu_ebb0d7', 1465859724, 'f', 1, NULL, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483634, 'stu_5554fd', 'stu_ebb0d7', -1349201381, 'f', 1, NULL, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483633, 'stu_5554fd', 'stu_ebb0d7', 1019800248, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483632, 'stu_5554fd', 'stu_ebb0d7', -1910425938, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483631, 'stu_5554fd', 'stu_ebb0d7', -845863578, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483630, 'stu_5554fd', 'stu_ebb0d7', -1610064545, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483629, 'stu_5554fd', 'stu_ebb0d7', 429706943, 'f', 1, 1, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483628, 'stu_5554fd', 'stu_ebb0d7', 462974032, 'f', 1, 1, 'db6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT advisor, major, COUNT(*) AS n FROM student GROUP BY advisor, major) WHERE (advisor = 1121 OR n > 1121) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Student WHERE Advisor = 1121;

/*
Prediction Result:
(0,)
*/