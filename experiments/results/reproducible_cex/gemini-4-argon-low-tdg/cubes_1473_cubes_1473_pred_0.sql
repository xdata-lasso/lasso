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
-- DATASET 1
-- Tests basic filtering, boundary conditions on gradepoint (>, =, < 3.8), DISTINCT elimination, and Fname vs LName column selection.
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (1, 'AS', 'CompSci', '101', 'Gates', 1234);
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'ProfL', 'ProfF', 'Prof', 'M', 5678, '202', 'Gates');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS101', 1, 1, 'Intro CS', 3, 'MWF', '9-10');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS102', 1, 1, 'Data Struct', 4, 'TTh', '10-12');
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('A+', 4.3);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('A', 4.0);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('A-', 3.8);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('B+', 3.3);
-- Student 1: Multiple courses with gradepoint > 3.8 (Tests DISTINCT on single student)
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Alice', 20, 'F', 1, 1, 'NYC');
-- Student 2: Same Fname 'Alice', different StuID, also > 3.8 (Tests DISTINCT across students)
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Jones', 'Alice', 22, 'F', 1, 1, 'LA');
-- Student 3: Exactly 3.8 (Boundary test: catches >= 3.8 vs > 3.8)
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Bob', 21, 'M', 1, 1, 'CHI');
-- Student 4: Below 3.8 (Catches <, <=, or missing WHERE clause)
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Davis', 'Charlie', 19, 'M', 1, 1, 'BOS');
-- Student 5: Mixed grades (one > 3.8, one < 3.8)
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Wilson', 'Zack', 23, 'M', 1, 1, 'SEA');
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A+', 'CS101', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS102', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS101', 2);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A-', 'CS101', 3);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('B+', 'CS101', 4);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS101', 5);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('B+', 'CS102', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname" FROM (SELECT "stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code", "cid", "grade", "gradepoint", "grade" AS "lettergrade" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."cid" AS "cid", "LHS"."grade" AS "grade", "RHS"."gradepoint" AS "gradepoint" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."cid" AS "cid", "RHS"."grade" AS "grade" FROM "student" AS "LHS" INNER JOIN "enrolled_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "gradeconversion" AS "RHS" ON ("LHS"."grade" = "RHS"."lettergrade"))) WHERE ("gradepoint" > '3.8') ORDER BY fname, "fname" NULLS LAST;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT T3.Fname FROM ENROLLED_IN AS T1 CROSS JOIN GRADECONVERSION AS T2 JOIN STUDENT AS T3 ON T1.Grade = T2.lettergrade AND T1.StuID = T3.StuID WHERE T2.gradepoint >= 3.8;

/*
Prediction Result:
('Alice',)
('Bob',)
('Zack',)
*/