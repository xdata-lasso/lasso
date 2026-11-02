-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

CREATE TABLE "Department" ("DNO" INTEGER PRIMARY KEY, "Division" TEXT(2), "DName" TEXT(25), "Room" TEXT(5), "Building" TEXT(13), "DPhone" INTEGER);

CREATE TABLE "Member_of" ("DNO" INTEGER, "FacID" INTEGER, "Appt_Type" TEXT(15), FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Course" ("CID" TEXT(7) PRIMARY KEY, "DNO" INTEGER, "Instructor" INTEGER, "CName" TEXT(40), "Credits" INTEGER, "Days" TEXT(5), "Hours" TEXT(11), FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("Instructor") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Minor_in" ("DNO" INTEGER, "StuID" INTEGER, FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Enrolled_in" ("Grade" TEXT(2), "CID" TEXT(7), "StuID" INTEGER, FOREIGN KEY ("Grade") REFERENCES "Gradeconversion" ("lettergrade"), FOREIGN KEY ("CID") REFERENCES "Course" ("CID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Gradeconversion" ("lettergrade" TEXT(2) PRIMARY KEY, "gradepoint" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: department --
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (-2147483648, '23', 'dep_a90c17', '41e62', 'dep_9335f9', -1981402255);

-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (2, 'stu_5554fd', 't3__0619de', -55602865, 'f', -59984348, -664303813, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (3, 'stu_5554fd', 'stu_ebb0d7', 1871297066, 'f', 809183447, 89267185, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'stu_5554fd', 'stu_ebb0d7', -1364429300, 'f', -1257178728, 1236688122, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (4, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (5, 'stu_5554fd', 'stu_ebb0d7', -1981402255, 'f', -890215420, 1610062532, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (6, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483642, 'stu_5554fd', NULL, -1022641847, 'f', -1726781632, 247012447, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (7, 'stu_5554fd', 'stu_ebb0d7', -106629402, 'f', 1871297066, 809183447, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483640, 'stu_5554fd', NULL, 89267185, 'f', -1865039888, 1160656988, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (8, 'stu_5554fd', 'stu_ebb0d7', -252690330, 'f', 1115440883, 1644814318, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483638, 'stu_5554fd', NULL, 1465859724, 'f', -1349201381, 1019800248, 'db6');

-- Inserting into table: faculty --
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (-2147483648, 'fac_7ec0ad', 'fac_d8837b', 'fac_80d96e', '1', -890215420, '24d2f', 'fac_a140e0');

-- Inserting into table: course --
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('cid_1', -2147483648, -2147483648, 'cou_59898b', 1610062532, '0ce45', 'cou_0aeae2');

-- Inserting into table: gradeconversion --
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('t2__df0e2e', 3.8);

INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('A', 3.79);

INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('@', NULL);

INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('H', 3.8);

INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('B', 3.8);

INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('C', 3.8);

-- Inserting into table: enrolled_in --
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 2);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 2);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 2);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 2);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 2);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 2);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('t2__df0e2e', 'cid_1', 3);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('A', 'cid_1', 4);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('@', 'cid_1', 5);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('H', 'cid_1', 6);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('B', 'cid_1', 7);

INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('C', 'cid_1', 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname" FROM (SELECT "stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code", "cid", "grade", "gradepoint", "grade" AS "lettergrade" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."cid" AS "cid", "LHS"."grade" AS "grade", "RHS"."gradepoint" AS "gradepoint" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."cid" AS "cid", "RHS"."grade" AS "grade" FROM "student" AS "LHS" INNER JOIN "enrolled_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "gradeconversion" AS "RHS" ON ("LHS"."grade" = "RHS"."lettergrade"))) WHERE ("gradepoint" > '3.8') ORDER BY fname, "fname" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T3.Fname FROM ENROLLED_IN AS T1 CROSS JOIN GRADECONVERSION AS T2 JOIN STUDENT AS T3 ON T1.Grade = T2.lettergrade AND T1.StuID = T3.StuID WHERE T2.gradepoint >= 3.8;

/*
Prediction Result:
('t3__0619de',)
('stu_ebb0d7',)
*/