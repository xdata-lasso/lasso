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
-- Tests column order/projection swaps (distinct values across all columns),
-- ORDER BY cid ASC vs insertion order/DESC/other column orderings,
-- and INNER JOIN mutants with Enrolled_in (Course contains rows not in Enrolled_in, and Enrolled_in has multiple rows for one course to catch duplicate rows from unrequested joins).
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (10, 'EN', 'Computer Science', '101', 'Gates', 1111);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (20, 'AS', 'Mathematics', '202', 'Hilbert', 2222);
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (100, 'Smith', 'John', 'Prof', 'M', 5551, '301', 'Gates');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (200, 'Doe', 'Jane', 'Assoc', 'F', 5552, '402', 'Hilbert');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Adams', 'Alice', 20, 'F', 10, 100, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Baker', 'Bob', 22, 'M', 20, 200, 'LAX');
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('A', 4.0);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('B', 3.0);
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS300', 10, 200, 'Algorithms', 4, 'MWF', '10:00-11:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS100', 20, 100, 'Zealotry in Computing', 3, 'TTh', '09:00-10:30');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('MA200', 10, 100, 'Calculus', 1, 'F', '13:00-16:00');
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS100', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('B', 'CS100', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cid, cname, credits, instructor, days, hours, dno FROM course ORDER BY cid;

/*
Gold Result:
('CS100', 'Zealotry in Computing', 3, 100, 'TTh', '09:00-10:30', 20)
('CS300', 'Algorithms', 4, 200, 'MWF', '10:00-11:00', 10)
('MA200', 'Calculus', 1, 100, 'F', '13:00-16:00', 10)
*/

-- Prediction Query
SELECT * FROM COURSE ORDER BY Credits, COURSE.cid NULLS LAST;

/*
Prediction Result:
('MA200', 10, 100, 'Calculus', 1, 'F', '13:00-16:00')
('CS100', 20, 100, 'Zealotry in Computing', 3, 'TTh', '09:00-10:30')
('CS300', 10, 200, 'Algorithms', 4, 'MWF', '10:00-11:00')
*/