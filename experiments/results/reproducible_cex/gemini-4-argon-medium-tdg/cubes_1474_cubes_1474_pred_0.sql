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
-- DATASET 2
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (10, 'EN', 'CS', '101', 'B1', 1111);
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (100, 'Prof', 'One', 'Prof', 'M', 2222, '202', 'B1');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS101', 10, 100, 'Intro CS', 3, 'MWF', '9:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS102', 10, 100, 'Data Struct', 4, 'TTh', '10:00');
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('A', 4.0);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('B', 3.0);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Alice', 20, 'F', 10, 100, 'NYC');
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS101', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS102', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('B', 'CS101', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, gradepoint FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.cid AS cid, RHS.grade AS grade, RHS.gradepoint AS gradepoint, RHS.lettergrade AS lettergrade FROM student AS LHS INNER JOIN (SELECT stuid, cid, grade, gradepoint, grade AS lettergrade FROM (SELECT LHS.stuid AS stuid, LHS.cid AS cid, LHS.grade AS grade, RHS.gradepoint AS gradepoint FROM enrolled_in AS LHS INNER JOIN gradeconversion AS RHS ON (LHS.grade = RHS.lettergrade))) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY fname, lname NULLS LAST, gradepoint NULLS LAST;

/*
Gold Result:
('Alice', 'Smith', 3.0)
('Alice', 'Smith', 4.0)
('Alice', 'Smith', 4.0)
*/

-- Prediction Query
SELECT T3.Fname, T3.LName, T2.gradepoint FROM ENROLLED_IN AS T1 CROSS JOIN GRADECONVERSION AS T2 JOIN STUDENT AS T3 ON T1.Grade = T2.lettergrade AND T1.StuID = T3.StuID;

/*
Prediction Result:
('Alice', 'Smith', 4.0)
('Alice', 'Smith', 4.0)
('Alice', 'Smith', 3.0)
*/