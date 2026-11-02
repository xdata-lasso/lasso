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
-- Core test: Multiple students, duplicate output rows (DISTINCT vs ALL), tie-breaking in ORDER BY (fname, lname, gradepoint), and Faculty with identical names to catch table confusion.
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (1, 'EN', 'CS', '101', 'EngBldg', 1234);
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (10, 'Smith', 'Alice', 'Prof', 'F', 5551, '201', 'EngBldg');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (11, 'FacultyL', 'FacultyF', 'Assoc', 'M', 5552, '202', 'EngBldg');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS101', 1, 10, 'Intro CS', 3, 'MWF', '10-11');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS102', 1, 11, 'Data Struct', 4, 'TTh', '1-2:30');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS103', 1, 10, 'Algorithms', 4, 'MWF', '11-12');
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('A', 4.0);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('B', 3.0);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('C', 2.0);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Alice', 20, 'F', 1, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Adams', 'Alice', 21, 'F', 1, 11, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Bob', 22, 'M', 1, 10, 'CHI');
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS101', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS102', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('B', 'CS103', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('C', 'CS101', 2);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('B', 'CS102', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, gradepoint FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.cid AS cid, RHS.grade AS grade, RHS.gradepoint AS gradepoint, RHS.lettergrade AS lettergrade FROM student AS LHS INNER JOIN (SELECT stuid, cid, grade, gradepoint, grade AS lettergrade FROM (SELECT LHS.stuid AS stuid, LHS.cid AS cid, LHS.grade AS grade, RHS.gradepoint AS gradepoint FROM enrolled_in AS LHS INNER JOIN gradeconversion AS RHS ON (LHS.grade = RHS.lettergrade))) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY fname, lname NULLS LAST, gradepoint NULLS LAST;

/*
Gold Result:
('Alice', 'Adams', 2.0)
('Alice', 'Smith', 3.0)
('Alice', 'Smith', 4.0)
('Alice', 'Smith', 4.0)
('Bob', 'Brown', 3.0)
*/

-- Prediction Query
SELECT T3.Fname, T3.LName, T2.gradepoint FROM ENROLLED_IN AS T1 CROSS JOIN GRADECONVERSION AS T2 JOIN STUDENT AS T3 ON T1.Grade = T2.lettergrade AND T1.StuID = T3.StuID;

/*
Prediction Result:
('Alice', 'Smith', 4.0)
('Alice', 'Smith', 4.0)
('Alice', 'Smith', 3.0)
('Alice', 'Adams', 2.0)
('Bob', 'Brown', 3.0)
*/