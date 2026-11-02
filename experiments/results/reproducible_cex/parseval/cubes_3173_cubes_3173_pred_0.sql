-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483648, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', 1, -59984348, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'stu_5554fd', 'stu_ebb0d7', -664303813, 'f', 1, -1022641847, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483646, 'stu_5554fd', 'stu_ebb0d7', -1726781632, 'f', 1, 247012447, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483645, 'stu_5554fd', 'stu_ebb0d7', -1980249628, 'f', 1, -734455130, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483644, 'stu_5554fd', 'stu_ebb0d7', 1744686505, 'f', 1, -1633151678, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483643, 'stu_5554fd', 'stu_ebb0d7', -252690330, 'f', 1, 1115440883, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483642, 'stu_5554fd', 'stu_ebb0d7', 1644814318, 'f', 1, 1465859724, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483641, 'stu_5554fd', 'stu_ebb0d7', -1349201381, 'f', 1, 1019800248, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483640, 'stu_5554fd', 'stu_ebb0d7', -1910425938, 'f', 1, -845863578, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483639, 'stu_5554fd', 'stu_ebb0d7', -1610064545, 'f', 1, 429706943, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483638, 'stu_5554fd', 'stu_ebb0d7', 462974032, 'f', 1, -1137908826, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483637, 'stu_5554fd', 'stu_ebb0d7', -918961358, 'f', 1, -1602639011, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483636, 'stu_5554fd', 'stu_ebb0d7', -45536098, 'f', NULL, 1861536320, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483635, 'stu_5554fd', 'stu_ebb0d7', 44952191, 'f', NULL, 1151980946, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483634, 'stu_5554fd', 'stu_ebb0d7', 1620389964, 'f', NULL, 546571701, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483633, 'stu_5554fd', 'stu_ebb0d7', 947159877, 'f', 1, 1990080517, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483632, 'stu_5554fd', 'stu_ebb0d7', 1408123494, 'f', 1, -1964997180, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483631, 'stu_5554fd', 'stu_ebb0d7', 1149850321, 'f', 1, -1833165707, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483630, 'stu_5554fd', 'stu_ebb0d7', 1155439218, 'f', 1, 1313172851, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483629, 'stu_5554fd', 'stu_ebb0d7', -761141909, 'f', 1, 283598170, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483628, 'stu_5554fd', 'stu_ebb0d7', 742285925, 'f', 1, -747753377, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483627, 'stu_5554fd', 'stu_ebb0d7', 902887186, 'f', 1, -967741825, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483626, 'stu_5554fd', 'stu_ebb0d7', 775304493, 'f', 1, 373262291, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483625, 'stu_5554fd', 'stu_ebb0d7', -472966518, 'f', 1, -921187550, 'db6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major, n AS count___ FROM (SELECT major, COUNT(*) AS n FROM student GROUP BY major) WHERE (n >= 2 AND n < 30) ORDER BY major, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
(1, 21)
*/

-- Prediction Query
SELECT Major, COUNT(*) FROM Student GROUP BY Major HAVING COUNT(Major) BETWEEN 2 AND 30;

/*
Prediction Result:
(1, 21)
*/