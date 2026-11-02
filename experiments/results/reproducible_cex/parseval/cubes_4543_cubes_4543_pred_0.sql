-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

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

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483639, 'stu_5554fd', 'stu_ebb0d7', -1610064545, 'f', NULL, 429706943, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483638, 'stu_5554fd', 'stu_ebb0d7', 462974032, 'f', NULL, -1137908826, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483637, 'stu_5554fd', 'stu_ebb0d7', -918961358, 'f', NULL, -1602639011, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483636, 'stu_5554fd', 'stu_ebb0d7', -45536098, 'f', 1, 1861536320, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483635, 'stu_5554fd', 'stu_ebb0d7', 44952191, 'f', 1, 1151980946, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483634, 'stu_5554fd', 'stu_ebb0d7', 1620389964, 'f', 1, 546571701, 'db6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT major, COUNT(*) AS n FROM student GROUP BY major) WHERE (n <= 3) ORDER BY major;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Major FROM STUDENT GROUP BY Major HAVING COUNT(*) < 3;

/*
Prediction Result:
*/